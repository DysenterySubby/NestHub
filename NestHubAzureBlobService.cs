using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Azure.Storage;
using Azure.Storage.Blobs;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

namespace MOCKAirBNB
{
    public static class NestHubAzureBlobService
    {
        private static string _storageAccName = "nesthubstorage";
        private static string _storageAccAccessKey = "KGGUf6LwCCtWDzGK2MiA2bF8ZDYI2WAnja9Pyfnva4zkFsrG8IAIFD6BcxSWQBiqasmx5yLgZOIE+AStD/1VXw==";
        private static readonly BlobServiceClient _blobServiceClient;


        static NestHubAzureBlobService()
        {
            StorageSharedKeyCredential credential = new StorageSharedKeyCredential(_storageAccName, _storageAccAccessKey);
            Uri blobUri = new Uri($"https://nesthubstorage.blob.core.windows.net");
            _blobServiceClient = new BlobServiceClient(blobUri, credential);
        }

        public static async Task UploadProfilePicture(string username, string file, Stream filepath)
        {
            BlobContainerClient userpicBlobContainer = _blobServiceClient.GetBlobContainerClient("userprofilepicture");
            BlobClient userpicBlob = userpicBlobContainer.GetBlobClient($"{username}/{username}.{file.Split('.')[1]}");
            
            await userpicBlob.UploadAsync(filepath, true);
        }
    }
}