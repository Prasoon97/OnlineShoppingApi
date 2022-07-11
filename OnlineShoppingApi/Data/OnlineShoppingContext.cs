using Microsoft.EntityFrameworkCore;
using OnlineShoppingApi.Models;

namespace OnlineShoppingApi.Data
{

    public class OnlineShoppingContext : DbContext
    {
        public OnlineShoppingContext(DbContextOptions<OnlineShoppingContext> options) : base(options)
        {

        }
        public DbSet<Product> Products { get; set; }
        public DbSet<Cart> Carts { get; set; }

        public DbSet<Order> Orders { get; set; }
        public DbSet<Address> Addresses { get; set; }
        public DbSet<PaymentDetail> PaymentDetails { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // modelBuilder.Entity<Order>()
            //        .HasOne(b => b.BillingAddress)
            //        .WithOne(a => a.OrderDetail)
            //        .OnDelete(DeleteBehavior.ClientSetNull);

            //         modelBuilder.Entity<Order>()
            //        .HasOne(b => b.ShippingAddress)
            //        .WithOne(a => a.OrderDetail)
            //        .OnDelete(DeleteBehavior.ClientSetNull);
        }
    }
}