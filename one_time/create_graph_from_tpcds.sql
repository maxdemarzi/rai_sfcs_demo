CREATE OR REPLACE TRANSIENT TABLE Edge(src INT, dst INT) AS (
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('date_dim', cs_sold_date_sk) FROM catalog_sales WHERE cs_sold_date_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('date_dim', cs_ship_date_sk) FROM catalog_sales WHERE cs_ship_date_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('date_dim', cr_returned_date_sk) FROM catalog_returns WHERE cr_returned_date_sk IS NOT NULL
UNION
   SELECT HASH('customer', c_customer_sk), HASH('date_dim', c_first_shipto_date_sk) FROM customer WHERE c_first_shipto_date_sk IS NOT NULL
UNION
   SELECT HASH('customer', c_customer_sk), HASH('date_dim', c_first_sales_date_sk) FROM customer WHERE c_first_sales_date_sk IS NOT NULL
UNION
   SELECT HASH('inventory', inv_date_sk, inv_item_sk, inv_warehouse_sk), HASH('date_dim', inv_date_sk) FROM inventory WHERE inv_date_sk IS NOT NULL
UNION
   SELECT HASH('promotion', p_promo_sk), HASH('date_dim', p_start_date_sk) FROM promotion WHERE p_start_date_sk IS NOT NULL
UNION
   SELECT HASH('promotion', p_promo_sk), HASH('date_dim', p_end_date_sk) FROM promotion WHERE p_end_date_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', ss_item_sk, ss_ticket_number), HASH('date_dim', ss_sold_date_sk) FROM store_sales WHERE ss_sold_date_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', sr_item_sk, sr_ticket_number), HASH('date_dim', sr_returned_date_sk) FROM store_returns WHERE sr_returned_date_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('date_dim', ws_sold_date_sk) FROM web_sales WHERE ws_sold_date_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('date_dim', ws_ship_date_sk) FROM web_sales WHERE ws_ship_date_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('date_dim', wr_returned_date_sk) FROM web_returns WHERE wr_returned_date_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('time_dim', cs_sold_time_sk) FROM catalog_sales WHERE cs_sold_time_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('time_dim', cr_returned_time_sk) FROM catalog_returns WHERE cr_returned_time_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', ss_item_sk, ss_ticket_number), HASH('time_dim', ss_sold_time_sk) FROM store_sales WHERE ss_sold_time_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', sr_item_sk, sr_ticket_number), HASH('time_dim', sr_return_time_sk) FROM store_returns WHERE sr_return_time_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('time_dim', ws_sold_time_sk) FROM web_sales WHERE ws_sold_time_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('time_dim', wr_returned_time_sk) FROM web_returns WHERE wr_returned_time_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('customer', cs_bill_customer_sk) FROM catalog_sales WHERE cs_bill_customer_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('customer', cs_ship_customer_sk) FROM catalog_sales WHERE cs_ship_customer_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('customer', cr_refunded_customer_sk) FROM catalog_returns WHERE cr_refunded_customer_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('customer', cr_refunded_customer_sk) FROM catalog_returns WHERE cr_refunded_customer_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('customer', cr_returning_customer_sk) FROM catalog_returns WHERE cr_returning_customer_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', ss_item_sk, ss_ticket_number), HASH('customer', ss_customer_sk) FROM store_sales WHERE ss_customer_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', sr_item_sk, sr_ticket_number), HASH('customer', sr_customer_sk) FROM store_returns WHERE sr_customer_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('customer', ws_bill_customer_sk) FROM web_sales WHERE ws_bill_customer_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('customer', ws_ship_customer_sk) FROM web_sales WHERE ws_ship_customer_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('customer', wr_refunded_customer_sk) FROM web_returns WHERE wr_refunded_customer_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('customer', wr_returning_customer_sk) FROM web_returns WHERE wr_returning_customer_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('item', cs_item_sk) FROM catalog_sales WHERE cs_item_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('item', cr_item_sk) FROM catalog_returns WHERE cr_item_sk IS NOT NULL
UNION
   SELECT HASH('inventory', inv_date_sk, inv_item_sk, inv_warehouse_sk), HASH('item', inv_item_sk) FROM inventory WHERE inv_item_sk IS NOT NULL
UNION
   SELECT HASH('promotion', p_promo_sk), HASH('item', p_item_sk) FROM promotion WHERE p_item_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', ss_item_sk, ss_ticket_number), HASH('item', ss_item_sk) FROM store_sales WHERE ss_item_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', sr_item_sk, sr_ticket_number), HASH('item', sr_item_sk) FROM store_returns WHERE sr_item_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('item', ws_item_sk) FROM web_sales WHERE ws_item_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('item', wr_item_sk) FROM web_returns WHERE wr_item_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('customer_demographics', cs_bill_cdemo_sk) FROM catalog_sales WHERE cs_bill_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('customer_demographics', cs_ship_cdemo_sk) FROM catalog_sales WHERE cs_ship_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('customer_demographics', cr_refunded_cdemo_sk) FROM catalog_returns WHERE cr_refunded_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('customer_demographics', cr_returning_cdemo_sk) FROM catalog_returns WHERE cr_returning_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('customer', c_customer_sk), HASH('customer_demographics', c_current_cdemo_sk) FROM customer WHERE c_current_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', ss_item_sk, ss_ticket_number), HASH('customer_demographics', ss_cdemo_sk) FROM store_sales WHERE ss_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', sr_item_sk, sr_ticket_number), HASH('customer_demographics', sr_cdemo_sk) FROM store_returns WHERE sr_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('customer_demographics', ws_bill_cdemo_sk) FROM web_sales WHERE ws_bill_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('customer_demographics', ws_ship_cdemo_sk) FROM web_sales WHERE ws_ship_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('customer_demographics', wr_refunded_cdemo_sk) FROM web_returns WHERE wr_refunded_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('customer_demographics', wr_returning_cdemo_sk) FROM web_returns WHERE wr_returning_cdemo_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('household_demographics', cs_bill_hdemo_sk) FROM catalog_sales WHERE cs_bill_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('household_demographics', cs_ship_hdemo_sk) FROM catalog_sales WHERE cs_ship_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('household_demographics', cr_refunded_hdemo_sk) FROM catalog_returns WHERE cr_refunded_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('household_demographics', cr_returning_hdemo_sk) FROM catalog_returns WHERE cr_returning_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('customer', c_customer_sk), HASH('household_demographics', c_current_hdemo_sk) FROM customer WHERE c_current_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', ss_item_sk, ss_ticket_number), HASH('household_demographics', ss_hdemo_sk) FROM store_sales WHERE ss_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', sr_item_sk, sr_ticket_number), HASH('household_demographics', sr_hdemo_sk) FROM store_returns WHERE sr_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('household_demographics', ws_bill_hdemo_sk) FROM web_sales WHERE ws_bill_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('household_demographics', ws_ship_hdemo_sk) FROM web_sales WHERE ws_ship_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('household_demographics', wr_refunded_hdemo_sk) FROM web_returns WHERE wr_refunded_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('household_demographics', wr_returning_hdemo_sk) FROM web_returns WHERE wr_returning_hdemo_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('customer_address', cs_bill_addr_sk) FROM catalog_sales WHERE cs_bill_addr_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('customer_address', cs_ship_addr_sk) FROM catalog_sales WHERE cs_ship_addr_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('customer_address', cr_refunded_addr_sk) FROM catalog_returns WHERE cr_refunded_addr_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cr_item_sk, cr_order_number), HASH('customer_address', cr_returning_addr_sk) FROM catalog_returns WHERE cr_returning_addr_sk IS NOT NULL
UNION
   SELECT HASH('customer', c_customer_sk), HASH('customer_address', c_current_addr_sk) FROM customer WHERE c_current_addr_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', ss_item_sk, ss_ticket_number), HASH('customer_address', ss_addr_sk) FROM store_sales WHERE ss_addr_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', sr_item_sk, sr_ticket_number), HASH('customer_address', sr_addr_sk) FROM store_returns WHERE sr_addr_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('customer_address', ws_bill_addr_sk) FROM web_sales WHERE ws_bill_addr_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('customer_address', ws_ship_addr_sk) FROM web_sales WHERE ws_ship_addr_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('customer_address', wr_refunded_addr_sk) FROM web_returns WHERE wr_refunded_addr_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', wr_item_sk, wr_order_number), HASH('customer_address', wr_returning_addr_sk) FROM web_returns WHERE wr_returning_addr_sk IS NOT NULL
UNION
   SELECT HASH('catalog_sales', cs_item_sk, cs_order_number), HASH('promotion', cs_promo_sk) FROM catalog_sales WHERE cs_promo_sk IS NOT NULL
UNION
   SELECT HASH('store_sales', ss_item_sk, ss_ticket_number), HASH('promotion', ss_promo_sk) FROM store_sales WHERE ss_promo_sk IS NOT NULL
UNION
   SELECT HASH('web_sales', ws_item_sk, ws_order_number), HASH('promotion', ws_promo_sk) FROM web_sales WHERE ws_promo_sk IS NOT NULL
UNION
   SELECT HASH('household_demographics', hd_demo_sk), HASH('income_band', hd_income_band_sk) FROM household_demographics WHERE hd_income_band_sk IS NOT NULL
);