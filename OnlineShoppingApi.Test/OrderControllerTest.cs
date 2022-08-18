using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using OnlineShoppingApi.Controllers;
using OnlineShoppingApi.Models;
using OnlineShoppingApi.Service;
using Xunit;
using static OnlineShoppingApi.Common.Constants;

namespace OnlineShoppingApi.Test
{

    public class OrderControllerTest
    {
        private readonly OrderController _controller;
        Mock<ILogger<OrderController>> _logger;
        Mock<IOrderService> _orderService;

        public OrderControllerTest()
        {
            _logger = new Mock<ILogger<OrderController>>();
            _orderService = new Mock<IOrderService>();
            _controller = new OrderController(_logger.Object, _orderService.Object);
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
            _orderService.Setup(x => x.GetOrderByUserId(It.IsAny<string>())).Returns(expectedResult);

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
            _orderService.Setup(x => x.GetOrderByUserId(It.IsAny<string>())).Returns(emptyOrderList);

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
            _orderService.Setup(x => x.OrderProducts(order)).Returns(true);

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
            _orderService.Setup(x => x.OrderProducts(order)).Returns(false);

            //Act
            var actionResult = _controller.PlaceOrder(order);
            var result = actionResult as ObjectResult;

            //Assert
            Assert.IsType<ObjectResult>(result);
            Assert.Equal(StatusCodes.Status500InternalServerError, result.StatusCode);
        }
    }
}