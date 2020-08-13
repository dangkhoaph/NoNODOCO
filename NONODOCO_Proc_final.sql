/****************** Stored Procedures 1 ***********************/
--Thống kê những booking đã thực hiện trong ngày sort theo số tiền
USE [NONODOCO_Final]
GO
Create proc sp_Selecte_Booking_Top100_Money_BookingInDate
@date date
As
SELECT TOP(100) [BookingID]
      ,[BookingTime]
      ,[Money]
      ,[FromPlace]
      ,[ToPlace]
      ,[Distance]
      ,[MatchingID]
      ,[CustomerID]
      ,[RestaurantID]
      ,[VehicleID]
      ,[Status]
      ,[RateFeedback]
      ,[MessageFeedback]
FROM Booking
WHERE BookingTime = @date
ORDER BY [Money] DESC
GO
--exec
EXEC sp_Selecte_Booking_Top100_Money_BookingInDate '2020-07-22';
GO

/****************** Stored Procedures 2 ***********************/
--Thống kê những Địa điểm được book nhiều nhất trong ngày
USE [NONODOCO_Final]
GO
Create proc sp_Selecte_Booking_Top100_Place_BookingInDate
@date date
As
SELECT TOP(100) [FromPlace], COUNT(FromPlace) AS Quantity
FROM Booking
WHERE BookingTime = @date
GROUP BY FromPlace
ORDER BY Quantity DESC
GO
--exec
EXEC sp_Selecte_Booking_Top100_Place_BookingInDate '2020-07-22';
GO

/****************** Stored Procedures 3 ***********************/
--Tổng cuốc chạy trong ngày
USE [NONODOCO_Final]
GO
Create proc sp_Selecte_Booking_Count_BookingInDate
@date date,
@status varchar(50)
As
SELECT COUNT([BookingID]) AS QuantityBooking
FROM Booking
WHERE BookingTime = @date AND [Status] Like @status
GO
--exec
EXEC sp_Selecte_Booking_Count_BookingInDate '2020-07-22', '%Success%';
EXEC sp_Selecte_Booking_Count_BookingInDate '2020-07-22', '%Cancelleđ%';
EXEC sp_Selecte_Booking_Count_BookingInDate '2020-07-22', '%Process%';
GO

/****************** Stored Procedures 4 ***********************/
--Tổng Số tiền của các cuốc chạy trong ngày
USE [NONODOCO_Final]
GO
Create proc sp_Selecte_Booking_Sum_Money_BookingInDate
@date date,
@status varchar(50)
As
SELECT SUM([Money]) AS SumMoney
FROM Booking
WHERE BookingTime = @date AND [Status] Like @status
GO
--exec
EXEC sp_Selecte_Booking_Sum_Money_BookingInDate '2020-07-22', '%Success%';
EXEC sp_Selecte_Booking_Sum_Money_BookingInDate '2020-07-22', '%Cancelleđ%';
EXEC sp_Selecte_Booking_Sum_Money_BookingInDate '2020-07-22', '%Process%';
GO

/****************** Stored Procedures 5 ***********************/
--Tổng Số tiền của các cuốc chạy trong thang
USE [NONODOCO_Final]
GO
Create proc sp_Selecte_Booking_Sum_Money_BookingInMonth
@dateFrom date,
@dateTo date,
@status varchar(50)
As
SELECT SUM([Money]) AS SumMoney
FROM Booking
WHERE BookingTime BETWEEN @dateFrom AND @dateTo AND [Status] Like @status;
GO
--exec
EXEC sp_Selecte_Booking_Sum_Money_BookingInMonth '2020-07-01' , '2020-08-01', '%Success%';
GO

/*
/****************** Stored Procedures 6 ***********************/
--Top 10 Main Drive có nhiều cuốc chạy nhiều nhất trong ngày
Create proc sp_Selecte_Main_Driver_TOP10_MainDriver_BookingInDay
@date date
As
SELECT TOP(10) MainDriverID, FullName, PhoneNumber, Email 
FROM [dbo].[Main_Driver]
WHERE BookingTime 
GO
--exec
EXEC sp_Selecte_Booking_Sum_Money_BookingInMonth '2020-07-01' , '2020-08-01';
GO

*/