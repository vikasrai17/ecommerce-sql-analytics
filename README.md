# E-commerce SQL Analytics

This project analyzes an e-commerce order dataset with MySQL to identify sales trends, customer value, product performance, discount impact, returns, shipping patterns, and cross-sell opportunities.

The analysis uses three source files in `data/`, reusable SQL scripts in `queries/`, and exported query results in `outputs/`.

## Project Structure

```text
.
├── data/
│   ├── orders.csv
│   ├── people.csv
│   └── returns.csv
├── queries/
│   ├── Customer_Segmentation.sql
│   ├── Discount_impact.sql
│   ├── MoM_sales.sql
│   ├── Product_Affinity.sql
│   ├── Product_performance.sql
│   ├── Profit_margin.sql
│   ├── Return_rate.sql
│   ├── Sales_Average.sql
│   ├── Shipping.sql
│   ├── Top_customers.sql
│   └── YoY_sales.sql
└── outputs/
    └── CSV exports for each analysis query
```

## Dataset

The main dataset is `data/orders.csv`, with 9,993 order rows and columns such as:

- `OrderID`, `OrderDate`, `ShipDate`, `ShipMode`
- `CustomerID`, `CustomerName`, `Segment`, `Region`
- `Category`, `Sub_Category`, `ProductName`
- `Sales`, `Quantity`, `Discount`, `Profit`

Supporting datasets:

- `data/people.csv`: regional manager mapping by region
- `data/returns.csv`: returned order IDs

## Tools Used

- MySQL 8+
- SQL window functions
- Common table expressions
- CSV exports for analysis outputs

## Analysis Summary

| Analysis | Query | Output | Purpose |
| --- | --- | --- | --- |
| Overall profit margin | `queries/Profit_margin.sql` | `outputs/Profit_margin.csv` | Measures total sales, total profit, order count, and profit margin |
| Year-over-year sales | `queries/YoY_sales.sql` | `outputs/YoY_sales.csv` | Tracks annual sales growth |
| Month-over-month sales | `queries/MoM_sales.sql` | `outputs/MoM_sales.csv` | Compares monthly sales against the previous month |
| Rolling sales average | `queries/Sales_Average.sql` | `outputs/Sales_Average.csv` | Calculates 3-month rolling revenue trend |
| Product performance | `queries/Product_performance.sql` | `outputs/Product_performance.csv` | Finds profitable and unprofitable categories/sub-categories |
| Discount impact | `queries/Discount_impact.sql` | `outputs/Discount_impact.csv` | Measures how discount tiers affect profit |
| Customer segmentation | `queries/Customer_Segmentation.sql` | `outputs/Customer_Segmentation.csv` | Groups customers into Platinum, Gold, and Silver tiers |
| Top customers by region | `queries/Top_customers.sql` | `outputs/Top_customers.csv` | Identifies the top 3 customers in each region |
| Return rate | `queries/Return_rate.sql` | `outputs/Return_rate.csv` | Measures returns by regional manager and category |
| Product affinity | `queries/Product_Affinity.sql` | `outputs/Product_Affinity.csv` | Finds frequently co-purchased sub-category pairs |
| Shipping performance | `queries/Shipping.sql` | `outputs/Shipping.csv` | Compares ship modes by sales and profit |

## Key Findings

### Overall Performance

- Total sales: `$2,263,520.49`
- Total profit: `$280,612.78`
- Total distinct orders: `4,925`
- Overall profit margin: `12.4%`

The business is profitable overall, but margin is modest. Profit improvement should focus on discount controls, loss-making product groups, and return reduction.

### Sales Growth

Annual sales declined in 2019, then recovered strongly:

| Year | Sales | YoY Growth |
| --- | ---: | ---: |
| 2018 | `$481,763.80` | N/A |
| 2019 | `$459,306.14` | `-4.66%` |
| 2020 | `$598,298.20` | `30.26%` |
| 2021 | `$724,152.35` | `21.04%` |

Sales momentum improved significantly in 2020 and 2021, showing healthy revenue growth after the 2019 decline.

### Discount Impact

| Discount Tier | Orders | Sales | Profit | Avg Profit per Order |
| --- | ---: | ---: | ---: | ---: |
| No Discount | 4,646 | `$1,063,847.95` | `$314,939.07` | `$67.79` |
| Low Discount, 1-20% | 3,693 | `$838,235.31` | `$99,827.47` | `$27.03` |
| Medium Discount, 21-50% | 536 | `$298,469.48` | `-$58,825.40` | `-$109.75` |
| High Discount, >50% | 808 | `$62,967.74` | `-$75,328.37` | `-$93.23` |

Discounts above 20% are unprofitable. Medium and high discount tiers together generated more than `$134K` in losses.

### Product Performance

Most profitable sub-categories:

- Copiers: `$55,617.82` profit, `37.2%` margin
- Phones: `$44,111.24` profit, `13.43%` margin
- Accessories: `$41,825.98` profit, `25.03%` margin
- Paper: `$32,668.83` profit, `43.41%` margin
- Binders: `$29,983.02` profit, `15.0%` margin

Loss-making sub-categories:

- Tables: `-$17,725.48` profit, `-8.56%` margin
- Bookcases: `-$4,485.68` profit, `-4.06%` margin
- Supplies: `-$1,348.57` profit, `-2.93%` margin

Furniture has two major problem areas: Tables and Bookcases. These sub-categories reduce total company profitability despite meaningful sales volume.

### Customer Segmentation

Customer tiers:

| Segment | Customers |
| --- | ---: |
| Platinum Tier | 114 |
| Gold Tier | 321 |
| Silver Tier | 358 |

Top lifetime customers include:

- Sean Miller: `$25,043.05`
- Tamara Chand: `$19,017.85`
- Raymond Buch: `$15,117.34`
- Tom Ashbrook: `$14,595.62`
- Adrian Barton: `$14,355.61`

The top customers are highly valuable and should be protected with retention, loyalty, and account-based offers.

### Top Customers by Region

| Region | Top Customer | Total Spent |
| --- | --- | ---: |
| Central | Tamara Chand | `$18,402.77` |
| East | Tom Ashbrook | `$13,723.50` |
| South | Sean Miller | `$23,669.20` |
| West | Raymond Buch | `$14,345.28` |

Each region has a clear high-value customer base that can be targeted with regional campaigns.

### Returns

Highest return rates:

| Regional Manager | Category | Return Rate |
| --- | --- | ---: |
| Sadie Pawthorne | Furniture | `15.07%` |
| Sadie Pawthorne | Technology | `13.70%` |
| Sadie Pawthorne | Office Supplies | `12.84%` |
| Chuck Magee | Technology | `6.62%` |
| Fred Suzuki | Technology | `5.12%` |

Returns are heavily concentrated under Sadie Pawthorne's region across all categories. This may indicate fulfillment, product expectation, customer education, or regional quality-control issues.

### Product Affinity

Most common co-purchases:

| Product Pair | Frequency |
| --- | ---: |
| Binders + Paper | 241 |
| Binders + Phones | 190 |
| Binders + Storage | 185 |
| Binders + Furnishings | 173 |
| Paper + Phones | 163 |

Binders and Paper are the strongest bundle opportunity. Binders also pair well with Phones, Storage, and Furnishings.

## Business Recommendations

### 1. Limit Discounts Above 20%

Medium and high discounts are destroying profit. Discounts above 20% produced negative average profit per order.

Recommended actions:

- Require manager approval for discounts greater than 20%.
- Replace deep discounts with targeted bundles, loyalty credits, or limited-quantity promotions.
- Review SKUs that frequently need high discounts and decide whether to reprice, reposition, or discontinue them.

### 2. Improve or Reprice Loss-Making Product Lines

Tables, Bookcases, and Supplies are currently unprofitable.

Recommended actions:

- Audit supplier cost, shipping cost, return rate, and discounting for Tables and Bookcases.
- Increase prices or reduce discounts on loss-making Furniture items.
- Promote higher-margin alternatives such as Chairs, Furnishings, Paper, Copiers, and Accessories.

### 3. Build Campaigns Around High-Margin Products

Copiers, Paper, Labels, Envelopes, Accessories, and Art show strong margins.

Recommended actions:

- Prioritize these products in email campaigns and website recommendations.
- Use Paper, Labels, and Envelopes as profitable add-ons during checkout.
- Pair Technology products with Accessories to increase order value and margin.

### 4. Create Retention Programs for Platinum Customers

There are 114 Platinum customers with high lifetime spend.

Recommended actions:

- Create a VIP retention program for Platinum customers.
- Offer early access, dedicated support, or personalized reorder reminders.
- Monitor inactivity among top customers like Sean Miller, Tamara Chand, and Raymond Buch.

### 5. Use Product Affinity for Bundling and Cross-Selling

The strongest product pair is Binders + Paper.

Recommended actions:

- Create bundles for Binders + Paper, Binders + Storage, and Paper + Phones.
- Add "frequently bought together" recommendations at checkout.
- Test bundle discounts below 20% to protect margin while increasing basket size.

### 6. Investigate High Return Rates in Sadie Pawthorne's Region

Sadie Pawthorne's region has the highest return rates across Furniture, Technology, and Office Supplies.

Recommended actions:

- Review return reasons by category and product.
- Audit regional shipping, packaging, and product descriptions.
- Compare customer expectations, delivery damage, and support issues against lower-return regions.
- Start with Furniture, where the return rate is highest at `15.07%`.

### 7. Replicate Regional Customer Success

Each region has clear top customers who can anchor regional strategy.

Recommended actions:

- Build region-specific customer lists from `Top_customers.csv`.
- Study what top customers buy and use those patterns to find similar customers.
- Assign account follow-ups for the highest-spend customers in each region.

## Data Quality Notes

- `queries/Shipping.sql` subtracts formatted dates directly. In MySQL, use `DATEDIFF(new_ship_date, new_order_date)` for accurate days-to-ship.
- `queries/MoM_sales.sql` groups by `MONTH(orderdate)` without first converting the text date. If `OrderDate` is stored as text, use `STR_TO_DATE(OrderDate, '%m/%d/%Y')` before extracting the month.
- `outputs/MoM_sales.csv` contains a `NULL` month row, which likely comes from unparsed order dates.
- For production reporting, standardize column names and date parsing before running the analytics queries.

## How to Run

1. Create a MySQL database.
2. Import the CSV files from `data/` into tables named `Orders`, `People`, and `Returns`.
3. Confirm date columns are parsed correctly or use `STR_TO_DATE()` in the queries.
4. Run each SQL file from the `queries/` folder.
5. Export the result of each query into the matching CSV file in `outputs/`.

Example:

```sql
SOURCE queries/Profit_margin.sql;
SOURCE queries/Product_performance.sql;
SOURCE queries/Discount_impact.sql;
```

## Conclusion

The business has strong sales growth and positive total profit, but profitability is being reduced by deep discounting, unprofitable Furniture sub-categories, and concentrated return issues. The best opportunities are to control discounts above 20%, fix or reprice loss-making products, retain Platinum customers, and use product-affinity bundles to increase profitable order value.
