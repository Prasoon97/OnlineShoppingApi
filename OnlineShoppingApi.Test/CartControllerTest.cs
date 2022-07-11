using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using OnlineShoppingApi.Controllers;
using OnlineShoppingApi.Models;
using OnlineShoppingApi.Service;
using Xunit;

namespace OnlineShoppingApi.Test
{

    public class CartControllerTest
    {
        private readonly CartController _controller;
        Mock<ILogger<CartController>> _logger;
        Mock<ICartService> _cartService;

        public CartControllerTest()
        {
            _logger = new Mock<ILogger<CartController>>();
            _cartService = new Mock<ICartService>();
            _controller = new CartController(_logger.Object, _cartService.Object);
        }

        [Fact]
        public void MyCart_IfCartHasProduct_ReturnsOk()
        {
            //Arrange
            string userId = "testuserid";
            IQueryable<Cart> expectedCartDetails = new List<Cart>(){
                new Cart{ CartId=1, ProductId=1, Quantity=1,OrderId=null, UserId=userId},
                new Cart{ CartId=2, ProductId=10, Quantity=5,OrderId=null, UserId=userId}

            }.AsQueryable();
            _cartService.Setup(x => x.GetCartDetails(It.IsAny<string>())).Returns(expectedCartDetails);

            //Act
            var actionResult = _controller.MyCart();
            var result = actionResult as OkObjectResult;

            //Assert
            Assert.IsType<OkObjectResult>(result);
            Assert.Equal(expectedCartDetails, result.Value);
        }

        [Fact]
        public void MyCart_IfCartIsEmpty_ReturnsNotFound()
        {
            //Arrange
            string expectedMessage = "No product is added to cart, Cart Is Empty!!";
            IQueryable<Cart> emptyCartResult = new List<Cart>().AsQueryable();
            _cartService.Setup(x => x.GetCartDetails(It.IsAny<string>())).Returns(emptyCartResult);

            //Act
            var actionResult = _controller.MyCart();
            var result = actionResult as NotFoundObjectResult;

            //Assert
            Assert.IsType<NotFoundObjectResult>(result);
            Assert.Equal(expectedMessage, result.Value);
        }

        [Fact]
        public void AddToCart_IfProductAddedToCart_Returns201Created()
        {
            //Arrange
            Cart cartDetailToBeAdded = new Cart
            {
                CartId = 1,
                ProductId = 1,
                Quantity = 1,
                OrderId = null,
                UserId = "testuserid"
            };
            _cartService.Setup(x => x.AddToCart(cartDetailToBeAdded)).Returns(true);

            //Act
            var actionResult = _controller.AddToCart(cartDetailToBeAdded);
            var result = actionResult as CreatedAtActionResult;

            //Assert
            Assert.IsType<CreatedAtActionResult>(result);
            Assert.Equal(StatusCodes.Status201Created, result.StatusCode);
        }

        [Fact]
        public void AddToCart_IfProductIsNotAddedToCart_Returns500InternalServerError()
        {
            //Arrange
            Cart cartDetailToBeAdded = new Cart
            {
                CartId = 1,
                ProductId = 1,
                Quantity = 1,
                OrderId = null,
                UserId = "testuserid"
            };
            _cartService.Setup(x => x.AddToCart(cartDetailToBeAdded)).Returns(false);

            //Act
            var actionResult = _controller.AddToCart(cartDetailToBeAdded);
            var result = actionResult as ObjectResult;

            //Assert
            Assert.IsType<ObjectResult>(result);
            Assert.Equal(StatusCodes.Status500InternalServerError, result.StatusCode);
        }

        [Fact]
        public void MyOrder_IfPlacedOrderExist_ReturnsOk()
        {
            //Arrange

            IQueryable<Order> expectedResult = new List<Order>(){
                new Order{
                    OrderId=1,
                    UserId="testuserid",
                    Addresses=new List<Address>(){
                     new Address(){ AddressType=AddressType.ShippingAddress, AddressLine1="test line 1 Shipping", AddressLine2="test line 2",City="Test City", State="TestState" , ZipCode=123456},
                     new Address(){AddressType=AddressType.BillingAddress, AddressLine1="test line 1 Billing", AddressLine2="test line 2", City="Test City", State="TestState" , ZipCode=123456}
                     },
                    PaymentInfo=new PaymentDetail(){ Id=1,PaymentType="Net Banking", TotalAmount=10000}
                },
                  new Order{
                    OrderId=2,
                    UserId="testuserid",
                    Addresses=new List<Address>(){
                     new Address(){ AddressType=AddressType.ShippingAddress, AddressLine1="test line 1 Shipping", AddressLine2="test line 2",City="Test City", State="TestState" , ZipCode=123456},
                     new Address(){AddressType=AddressType.BillingAddress, AddressLine1="test line 1 Billing", AddressLine2="test line 2", City="Test City", State="TestState" , ZipCode=123456}
                     },
                    PaymentInfo=new PaymentDetail(){ Id=2,PaymentType="UPI", TotalAmount=1000}
                }
            }.AsQueryable();
            _cartService.Setup(x => x.GetOrderByUserId(It.IsAny<string>())).Returns(expectedResult);

            //Act
            var actionResult = _controller.MyOrders();
            var result = actionResult as OkObjectResult;

            //Assert
            Assert.IsType<OkObjectResult>(result);
            Assert.Equal(expectedResult, result.Value);
        }

        [Fact]
        public void MyOrder_IfPlacedOrderNotExist_ReturnsNotFound()
        {
            //Arrange
            string expectedMessage = "No orders placed yet!!";
            IQueryable<Order> emptyOrderList = new List<Order>().AsQueryable();
            _cartService.Setup(x => x.GetOrderByUserId(It.IsAny<string>())).Returns(emptyOrderList);

            //Act
            var actionResult = _controller.MyOrders();
            var result = actionResult as NotFoundObjectResult;

            //Assert
            Assert.IsType<NotFoundObjectResult>(result);
            Assert.Equal(expectedMessage, result.Value);
        }

        [Fact]
        public void PlaceOrder_IfOrderPlaced_ReturnsCreated()
        {

            //Arrange
            Order order = new Order
            {
                UserId = "testuserid",
                Addresses = new List<Address>(){
                     new Address(){  AddressLine1="test line 1 Shipping", AddressLine2="test line 2",City="Test City", State="TestState" , ZipCode=123456},
                     new Address(){ AddressLine1="test line 1 Billing", AddressLine2="test line 2", City="Test City", State="TestState" , ZipCode=123456}
                     },
                PaymentInfo = new PaymentDetail() { PaymentType = "Net Banking" }
            };
            _cartService.Setup(x => x.OrderProducts(order)).Returns(true);

            //Act
            var actionResult = _controller.PlaceOrder(order);
            var result = actionResult as CreatedAtActionResult;

            //Assert
            Assert.IsType<CreatedAtActionResult>(result);
            Assert.Equal(StatusCodes.Status201Created, result.StatusCode);
        }

        [Fact]
        public void PlaceOrder_IfOrderNotPlaced_Returns500InternalServerError()
        {

            //Arrange
            Order order = new Order
            {
                UserId = "testuserid",
                Addresses = new List<Address>(){
                     new Address(){  AddressLine1="test line 1 Shipping", AddressLine2="test line 2",City="Test City", State="TestState" , ZipCode=123456},
                     new Address(){ AddressLine1="test line 1 Billing", AddressLine2="test line 2", City="Test City", State="TestState" , ZipCode=123456}
                     },
                PaymentInfo = new PaymentDetail() { PaymentType = "Net Banking" }
            };
            _cartService.Setup(x => x.OrderProducts(order)).Returns(false);

            //Act
            var actionResult = _controller.PlaceOrder(order);
            var result = actionResult as ObjectResult;

            //Assert
            Assert.IsType<ObjectResult>(result);
            Assert.Equal(StatusCodes.Status500InternalServerError, result.StatusCode);
        }
    }
}