using System;
using System.Collections.Generic;
using System.ComponentModel;
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
    public class NestHubAzureBlobService
    {
        private readonly string _storageAccName = "nesthubstorage";
        private readonly string _storageAccAccessKey = "KGGUf6LwCCtWDzGK2MiA2bF8ZDYI2WAnja9Pyfnva4zkFsrG8IAIFD6BcxSWQBiqasmx5yLgZOIE+AStD/1VXw==";
        private readonly BlobServiceClient _blobServiceClient;


        public NestHubAzureBlobService()
        {
            StorageSharedKeyCredential credential = new StorageSharedKeyCredential(_storageAccName, _storageAccAccessKey);
            Uri blobUri = new Uri("https://nesthubstorage.blob.core.windows.net");
            _blobServiceClient = new BlobServiceClient(blobUri, credential);
            
        }

        public async Task UploadProfilePicture(string username, string file, Stream fileStream)
        {
            BlobContainerClient userpicBlobContainer = _blobServiceClient.GetBlobContainerClient("userprofilepicture");
            BlobClient userpicBlob = userpicBlobContainer.GetBlobClient($"{username}/{username}{Path.GetExtension(file)}");
            fileStream.Position = 0;
            await userpicBlob.UploadAsync(fileStream);
            fileStream.Dispose();
        }
    }
}