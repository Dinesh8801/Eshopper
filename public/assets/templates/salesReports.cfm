<cfif structKeyExists(URL, "dateRange")>
		<cfset dateRange = URL.dateRange>
		<cfset fromDate = ListGetAt(dateRange, 1, " to ")>
		<cfset toDate = ListGetAt(dateRange, 2, " to ")>
	<cfelse>
		<cfset toDate = DateFormat(Now(), 'yyyy-MM-dd')>
		<cfset fromDate = DateFormat(DateAdd("m", -1, Now()), 'yyyy-MM-dd')>
	</cfif>

	<cfquery name="GetSales" datasource="martDSN">
		SELECT p.ProductName, s.Price, s.SaleDate
		FROM Products p, Sales s
		WHERE p.ProductID = s.ProductID
		  AND CAST(s.SaleDate AS DATE) BETWEEN <cfqueryparam value="#DateFormat(fromDate, 'yyyy-MM-dd')#" cfsqltype="cf_sql_date">
		  AND <cfqueryparam value="#DateFormat(toDate, 'yyyy-MM-dd')#" cfsqltype="cf_sql_date">
	</cfquery>
	
	<cfquery name="GetCategory" datasource="martDSN">
		SELECT p.Category, s.ProductName 
		FROM Products p, Sales s 
		WHERE p.ProductID = s.ProductID 
		AND CAST(s.SaleDate AS DATE) BETWEEN <cfqueryparam value="#DateFormat(fromDate, 'yyyy-MM-dd')#" cfsqltype="cf_sql_date">
		AND <cfqueryparam value="#DateFormat(toDate, 'yyyy-MM-dd')#" cfsqltype="cf_sql_date">
	</cfquery>
	
	<cfquery dbtype="query" name="productSales">
		SELECT ProductName, COUNT(ProductName) AS SumByProduct 
		FROM GetSales 
		GROUP BY ProductName
	</cfquery>
	
	<cfquery dbtype="query" name="categorySales">
		SELECT Category, COUNT(ProductName) AS SumByCategory 
		FROM GetCategory 
		GROUP BY Category
	</cfquery>
	
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- Load jQuery before any other script -->
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/moment@2.29.1/moment.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
		
		<!-- Load Bootstrap CSS and JS -->
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Load DataTables CSS and JS -->
		<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">
		<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
		
		<!-- Load the Date Range Picker CSS -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
		
		<!-- Load custom admin.js script -->
		<script src="/Assignments/Eshopper/public/assets/js/admin.js"></script>
		<script src="/Assignments/Eshopper/public/assets/js/index.js"></script>
		<script src="/Assignments/Eshopper/public/assets/js/helpers.js"></script>
		<title>Product Sales Report</title>
	</head>
	
<body>
	<cfinclude template="adminHeader.cfm">
	<div class="container mt-2">
		<a href="adminDashboard.cfm" class="btn btn-secondary">Back</a>
		<h1 class="text-center mb-4">Sales Report</h1>

		<div class="row justify-content-center mb-2">
			<div class="col">
				<form method="get" action="salesReports.cfm">
					<div class="form-group">
						<label for="dateRange">Select Date Range</label>
						<input type="text" name="dateRange" id="dateRange" class="form-control" 
							   value="<cfif structKeyExists(URL, 'dateRange')><cfoutput>#URL.dateRange#</cfoutput><cfelse><cfoutput>#DateFormat(DateAdd('m', -1, Now()), 'yyyy-MM-dd')#</cfoutput> to <cfoutput>#DateFormat(Now(), 'yyyy-MM-dd')#</cfoutput></cfif>">
					</div>
					<button type="submit" class="btn btn-primary">Generate Report</button>
				</form>
			</div>
		</div>

		<div class="row justify-content-center">
			<div class="col-md-6">
				<cfchart
					title="Category Wise Sales"
					xAxisTitle="Category"
					yAxisTitle="No of Orders"
					font="Arial" 
					gridlines=6 
					showXGridlines="no" 
					showYGridlines="no" 
					showborder="no" 
					show3d="yes"
					chartWidth="480"
					chartheight="400" >
					
					<cfchartseries
						type="bar"
						query="categorySales"
						valuecolumn="SumByCategory"
						itemcolumn="Category"
						colorlist="##6666FF,##66FF66,##FF6666,##66CCCC"
						seriesColor="##xxFF33CC" 
						paintStyle="plain" >
					</cfchartseries>
					
				</cfchart>
			</div>

			<div class="col-md-6">
				<cfchart
					title="Product Wise Sales"
					tipStyle="mousedown"
					font="Times"
					fontsize=14
					fontBold="yes"
					backgroundColor="white"
					show3D="yes"
					chartWidth="750"
					chartheight="400">
					
			
					<cfchartseries
						type="pie"
						query="productSales"
						valueColumn="SumByProduct"
						itemColumn="ProductName"
						colorlist="##6666FF,##66FF66,##FF6666,##66CCCC" />
			</cfchart>
			</div>
		</div>
	</div>

</body>
</html>
