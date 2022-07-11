using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;
//using Newtonsoft.Json;

namespace OnlineShoppingApi.Models
{
    public class Order
    {
        [JsonIgnore]
        [Key]
         public int OrderId { get; set; }
        // [ForeignKey("ShippingAddress")]
        // [JsonIgnore]
        // public int? ShippingAddressId { get; set; }
        // [ForeignKey("BillingAddress")]
        // [JsonIgnore]
        // public int BillingAddressId { get; set; }
        [ForeignKey("PaymentInfo")]
        [JsonIgnore]
        public int PaymentId { get; set; }

        public ICollection<Address> Addresses { get; set; }
       // public Address BillingAddress { get; set; }
        public PaymentDetail PaymentInfo { get; set; }
        [JsonIgnore]
        public string? OrderStatus { get; set; }
        
        public ICollection<Cart>? Products { get; set; }
        [JsonIgnore]
        public string? UserId { get; set; }

        //[ForeignKey("UserDetail")]

        // [JsonIgnore]
        // public User? UserDetail { get; set; }

    }

}