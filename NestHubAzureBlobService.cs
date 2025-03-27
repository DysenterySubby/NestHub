using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using System.Web;
using Azure.Storage;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;

namespace MOCKAirBNB
{
    public static class NestHubAzureBlobService
    {
        private static readonly string _storageAccName = "nesthubstorage";
        private static readonly string _storageAccAccessKey = "KGGUf6LwCCtWDzGK2MiA2bF8ZDYI2WAnja9Pyfnva4zkFsrG8IAIFD6BcxSWQBiqasmx5yLgZOIE+AStD/1VXw==";
        private static readonly BlobServiceClient _blobServiceClient;


        static NestHubAzureBlobService()
        {
            StorageSharedKeyCredential credential = new StorageSharedKeyCredential(_storageAccName, _storageAccAccessKey);
            Uri blobUri = new Uri("https://nesthubstorage.blob.core.windows.net");
            _blobServiceClient = new BlobServiceClient(blobUri, credential);
            
        }

        public static async Task UploadProfilePicture(string username, string file, Stream fileStream)
        {
            BlobContainerClient userpicBlobContainer = _blobServiceClient.GetBlobContainerClient("userprofilepicture");
            BlobClient userpicBlob = userpicBlobContainer.GetBlobClient($"{username}/{username}");
            fileStream.Position = 0;
            await userpicBlob.UploadAsync(fileStream, new BlobHttpHeaders { ContentType = $"image/{Path.GetExtension(file).Replace(".", "")}" });
            fileStream.Dispose();
        }

        public static string GetProfilePicture(string username)
        {
            BlobContainerClient userpicBlobContainer = _blobServiceClient.GetBlobContainerClient("userprofilepicture");
            BlobClient userpicBlob = userpicBlobContainer.GetBlobClient($"{username}/{username}");
            return userpicBlob.Uri.ToString();
        }

        public static void UploadListingImages(IList<HttpPostedFile> postedFiles, string listingID)
        {
            BlobContainerClient listingpicBlobContainer = _blobServiceClient.GetBlobContainerClient("homelistings");

            int fileCount = 1;
            foreach (var file in postedFiles)
            {
                BlobClient listingpicBlob = listingpicBlobContainer.GetBlobClient($"{listingID}/listing-image-{fileCount}");
                using (Stream stream = file.InputStream)
                {
                    listingpicBlob.Upload(stream, new BlobHttpHeaders { ContentType = $"image/{Path.GetExtension(file.FileName).Replace(".", "")}" });
                }
                fileCount++;
            }
        }

        public static string GetListingPic(string propID)
        {
            BlobContainerClient listingBlobContainer = _blobServiceClient.GetBlobContainerClient("homelistings");
            BlobClient listingpicBlob = listingBlobContainer.GetBlobClient($"{propID}/listing-image-1");
            return listingpicBlob.Uri.ToString();
        }

        public static Dictionary<string, object> GetListingPictures(string propID)
        {
            Dictionary<string, object> imgURLS = new Dictionary<string, object>();
            BlobContainerClient listingBlobContainer = _blobServiceClient.GetBlobContainerClient("homelistings");

            int count = 1;
            foreach (var listingBlob in listingBlobContainer.GetBlobsByHierarchy(prefix: propID))
            {
                imgURLS[$"img-{count}"] = listingBlobContainer.Uri.ToString() + "/" + listingBlob.Blob.Name;
                count++;
            }
            return imgURLS;
        }

        public static void DeleteListingBlob(string PropID)
        {
            BlobContainerClient listingBlobContainer = _blobServiceClient.GetBlobContainerClient("homelistings");
            foreach (BlobHierarchyItem blobItem in listingBlobContainer.GetBlobsByHierarchy(prefix:  PropID))
            {
                listingBlobContainer.DeleteBlob(blobItem.Blob.Name);
            }
        }

        public static void DeleteUserpicBlob(string UserID)
        {

            BlobContainerClient userpicBlobContainer = _blobServiceClient.GetBlobContainerClient("userprofilepicture");
            BlobClient userpicBlob = userpicBlobContainer.GetBlobClient($"{UserID}/{UserID}");
            userpicBlob.DeleteIfExists(Azure.Storage.Blobs.Models.DeleteSnapshotsOption.IncludeSnapshots, null, default);
        }
    }
}