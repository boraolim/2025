using Microsoft.AspNetCore.Http;

using Core.Domain.Common;

using MainConstantsCore = Core.Domain.Constants.MainConstants;
using FileConstantsCore = Core.Domain.Constants.FileConstants;
using FormatConstantsCore = Core.Domain.Constants.FormatConstants;

namespace Core.Utils.Functions;

public static class FilesUtils
{
    public static byte[] StringToByteArray(string hexString)
    {
        hexString = hexString.Replace("-", string.Empty).Replace(FormatConstantsCore.CFG_ZERO_HEX, string.Empty);
        return Enumerable.Range(0, hexString.Length / 2)
                         .Select(i => Convert.ToByte(hexString.Substring(i * 2, 2), 16))
                         .ToArray();
    }

    private static Dictionary<string, List<byte[]>> GetSignatures() => new Dictionary<string, List<byte[]>>
    {
        {   FileConstantsCore.CFG_EXT_GIF_FILE, new List<byte[]>
            {
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_GIF)
            }
        },
        {   FileConstantsCore.CFG_EXT_PNG_FILE, new List<byte[]>
            {
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_PNG),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_PNG_V0)
            }
        },
        {   FileConstantsCore.CFG_EXT_JPEG_FILE, new List<byte[]>
            {
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_JPG),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_JPG_V2),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_JPG_V3),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_JPG_V0)
            }
        },
        {   FileConstantsCore.CFG_EXT_JPG_FILE, new List<byte[]>
            {
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_JPG),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_JPG_V1),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_JPG_V8),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_JPG_V0)
            }
        },
        {   FileConstantsCore.CFG_EXT_PDF_FILE, new List<byte[]>
            {
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_PDF)
            }
        },
        {   FileConstantsCore.CFG_EXT_MPFOUR_FILE, new List<byte[]>
            {
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_FTYPISOM),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_FTYPMSNV),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_FTYP3GP),
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_FTYPMP42)
            }
        },
        {   FileConstantsCore.CFG_EXT_QUICK_TIME_FILE, new List<byte[]>
            {
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_FTYPQT)
            }
        },
        {   FileConstantsCore.CFG_EXT_THREEGP_FILE, new List<byte[]>
            {
                StringToByteArray(FileConstantsCore.CFG_HEX_FILE_FTYP3GP)
            }
        }
    };

    public static double TamanioArchivoEnMB(long tamanioEnBytes)
        => (tamanioEnBytes / (MainConstantsCore.CFG_BUFFER_VALUE * MainConstantsCore.CFG_BUFFER_VALUE));

    public static bool IsValidFileSignature(byte[] dataContentFile, bool isOffset = false, int SizeOffset = MainConstantsCore.CFG_ZERO)
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
                        .SelectMany(signatures => signatures)
                        .Any(validSignature => headerBytes.Take(validSignature.Length).SequenceEqual(validSignature));
                }
                catch { return false; }
            }
        }
    }

    public static bool IsValidFileSignatureByBitConverter(string dataContentFile, bool isOffset = false, int SizeOffset = MainConstantsCore.CFG_ZERO)
    {
        if(string.IsNullOrEmpty(dataContentFile))
            return false;

        byte[] fileBytes = StringToByteArray(dataContentFile.Replace(FormatConstantsCore.CFG_VALUE_DASH, string.Empty));

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
                while((Reader = await StreamDoc.ReadAsync(originalFile, MainConstantsCore.CFG_ZERO, originalFile.Length)) > MainConstantsCore.CFG_ZERO)
                {
                    await MStream.WriteAsync(originalFile, MainConstantsCore.CFG_ZERO, (int)Reader);
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
