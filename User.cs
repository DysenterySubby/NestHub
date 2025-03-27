using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MOCKAirBNB
{
    public class User
    {
        private string _userid;
        private string _username;
        private string _usertype;
        private string _email;

        public string UserID{  get { return _userid; }}
        public string Username { get { return _username; } }
        public string Email { get { return _email; } }
        public string IconURL { get { return NestHubAzureBlobService.GetProfilePicture(_username); } }
        public string UserType { get { return _usertype; }}
        public User(string userid,string username, string usertype, string useremail)
        {
            _userid = userid;
            _username = username;
            _usertype = usertype;
            _email = useremail;
        }
        public static string GenerateUserID()
        {
            Random random = new Random();
            string randomDigits = "";
            for (int i = 0; i < 6; i++)
                randomDigits += random.Next(0, 10);
            return DateTime.Now.Year.ToString() + randomDigits;
        }

    }

    
}