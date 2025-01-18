namespace Core.Application.Abstractions.Helpers;

public interface ICypherAes
{
    long Nonce { get; set; }
    string AESEncryptionGCM(string plainText);
    string AESDecryptionGCM(string encryptedText);
}
