using Microsoft.AspNetCore.Http;

using Core.Domain.Common;

using MainConstantsCore = Core.Domain.Constants.MainConstants;

namespace Core.Application.Utils;

public static class FilesUtils
{
    public static byte[] StringToByteArray(string hexString)
    {
        hexString = hexString.Replace("-", string.Empty).Replace(MainConstantsCore.CFG_ZERO_HEX, string.Empty);
        return Enumerable.Range(0, hexString.Length / 2)
                         .Select(i => Convert.ToByte(hexString.Substring(i * 2, 2), 16))
                         .ToArray();
    }

    /// <summary>
    /// Lista de signatures de algunas extensiones de archivos como imagenes (JPG, JPEG y GIF) y documentos portables (PDF).
    /// Fuente: https://www.sciencedirect.com/topics/computer-science/signature-file
    ///         https://www.garykessler.net/library/file_sigs.html
    /// </summary>
    /// <returns></returns>
    private static Dictionary<string, List<byte[]>> GetSignatures() => new Dictionary<string, List<byte[]>>
    {
        {   MainConstantsCore.CFG_EXT_GIF_FILE, new List<byte[]>
            {
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_GIF)
            }
        },
        {   MainConstantsCore.CFG_EXT_PNG_FILE, new List<byte[]>
            {
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_PNG),
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_PNG_V0)
            }
        },
        {   MainConstantsCore.CFG_EXT_JPEG_FILE, new List<byte[]>
            {
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_JPG),
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_JPG_V2),
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_JPG_V3),
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_JPG_V0)
            }
        },
        {   MainConstantsCore.CFG_EXT_JPG_FILE, new List<byte[]>
            {
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_JPG),
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_JPG_V1),
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_JPG_V8),
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_JPG_V0)
            }
        },
        {   MainConstantsCore.CFG_EXT_PDF_FILE, new List<byte[]>
            {
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_PDF)
            }
        },
        {   MainConstantsCore.CFG_EXT_MPFOUR_FILE, new List<byte[]>
            {
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_FTYPISOM), // ftypisom
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_FTYPMSNV), // ftypMSNV
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_FTYP3GP),  // ftyp3gp (Android)
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_FTYPMP42)  // ftypmp42 (MPEG-4 v2)
            }
        },
        {   MainConstantsCore.CFG_EXT_QUICK_TIME_FILE, new List<byte[]>
            {
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_FTYPQT)    // ftypqt (QuickTime videos, usados en iPhone)
            }
        },
        {   MainConstantsCore.CFG_EXT_THREEGP_FILE, new List<byte[]>
            {
                StringToByteArray(MainConstantsCore.CFG_HEX_FILE_FTYP3GP)   // ftyp3gp (videos en Android)
            }
        }
    };

    /// <summary>
    /// Calcular el tamaño del archivo en MegaBytes.
    /// </summary>
    /// <param name="tamanioEnBytes">Archivo en bytes.</param>
    /// <returns>Devuelve el equivalente a MB la cantidad de Bytes que ocupa un archivo.</returns>
    public static long TamanioArchivoEnMB(int tamanioEnBytes)
        => (tamanioEnBytes / (1024 * 1024));

    /// <summary>
    /// Función que valida el signature de un archivo.
    /// </summary>
    /// <param name="FileName">Nombre del archivo.</param>
    /// <param name="DataContentFile">Contenido en bytes del archivo.</param>
    /// <returns>True si el archivo validado tiene el signature correcto. En caso contrario, False.</returns>
    /// <remarks>
    /// Fuente: https://www.garykessler.net/library/file_sigs.html
    /// NOTA: Los arreglos de bytes deben estar en variables globales de entorno, preferentemente.
    /// </remarks>
    public static bool IsValidFileSignature(byte[] dataContentFile, bool isOffset = false, int SizeOffset = 0)
    {
        if(dataContentFile.CheckIsNull())
            return false;

        int maxHeaderLength = GetSignatures().Values.Max(list => list.Max(signature => signature.Length));

        using(MemoryStream stream = new MemoryStream(dataContentFile))
        {
            using(var reader = new BinaryReader(stream))
            {
                try
                {
                    if(isOffset && SizeOffset > 0)
                        reader.BaseStream.Seek(SizeOffset, SeekOrigin.Begin);

                    var headerBytes = reader.ReadBytes(maxHeaderLength);

                    return GetSignatures()
                        .Values
                        .SelectMany(signatures => signatures) // Combina todas las firmas en una lista plana
                        .Any(validSignature => headerBytes.Take(validSignature.Length).SequenceEqual(validSignature));
                }
                catch { return false; }
            }
        }
    }

    public static bool IsValidFileSignatureByBitConverter(string dataContentFile, bool isOffset = false, int SizeOffset = 0)
    {
        if(string.IsNullOrEmpty(dataContentFile))
            return false;

        byte[] fileBytes = StringToByteArray(dataContentFile.Replace(MainConstantsCore.CFG_VALUE_DASH, string.Empty));

        return IsValidFileSignature(fileBytes, isOffset, SizeOffset);
    }

    public static async Task<byte[]> GetBytesAync(this IFormFile formFile)
    {
        byte[] originalFile = null; long Reader = 0;

        using(Stream StreamDoc = formFile.OpenReadStream())
        {
            using(MemoryStream MStream = new MemoryStream())
            {
                originalFile = new byte[StreamDoc.Length + 1];
                while((Reader = await StreamDoc.ReadAsync(originalFile, 0, originalFile.Length)) > 0)
                {
                    await MStream.WriteAsync(originalFile, 0, (int)Reader);
                }
            }
        }

        return originalFile;
    }

    public static byte[] StreamToBytes(Stream input)
    {
        using(MemoryStream ms = new MemoryStream())
        {
            input.CopyTo(ms);
            return ms.ToArray();
        }
    }

    public static string GenerateRandomUUID() => Guid.NewGuid().ToString();
}
