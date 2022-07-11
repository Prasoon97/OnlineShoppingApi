using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace OnlineShoppingApi.Models
{
    [NotMapped]
    public class User
    {
        [JsonIgnore]
        public string? UserId { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
    }
}