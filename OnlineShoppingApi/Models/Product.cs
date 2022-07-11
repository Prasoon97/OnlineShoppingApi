using System.ComponentModel.DataAnnotations;

namespace OnlineShoppingApi.Models
{
    public class Product
    {
        [Key]
        [Required]
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public Decimal Price { get; set; }
        public string? Description { get; set; }
        [Required]
        public string Category { get; set; }
        [Required]
        public DateTime DateAdded { get; set; }
        
    }



}