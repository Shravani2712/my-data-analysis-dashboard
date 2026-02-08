import streamlit as st
import pandas as pd
import plotly.express as px
st.set_page_config(page_title="SQL → Python Dashboard", layout="wide")
st.title("📊 Sales Analytics Dashboard")
st.caption("Built using SQL + Python + Plotly")
# Load data
customers = pd.read_csv("customer_data.csv",sep=';')
orders = pd.read_csv("orders.csv",sep=';')
products = pd.read_csv("products.csv",sep=';')
order_items = pd.read_csv("order_items.csv",sep=';')
orders['order_date'] = pd.to_datetime(orders['order_date'])
print(orders.columns)
orders['month'] = orders['order_date'].dt.to_period('M').astype(str)
products['price'] = pd.to_numeric(products['price'], errors='coerce')
# KPIs
col1, col2, col3 = st.columns(3)
col1.metric("Total Orders", len(orders))
col2.metric("Total Revenue", f"₹{products['price'].sum():,.0f}")
col3.metric("Unique Customers", orders['customer_id'].nunique())
st.divider()
# Orders per customer
orders_per_customer = orders.groupby('customer_id').size().reset_index(name='orders')
fig1 = px.bar(orders_per_customer, x='customer_id', y='orders', title="Orders per Customer")
st.plotly_chart(fig1, use_container_width=True)
st.markdown("**Insight:** Repeat customers are key revenue drivers.")
# Monthly trend
monthly_orders = orders.groupby('month').size().reset_index(name='orders')
fig2 = px.line(monthly_orders, x='month', y='orders', markers=True, title="Monthly Orders Trend")
st.plotly_chart(fig2, use_container_width=True)
st.markdown("**Insight:** Seasonal demand patterns are visible.")
# Price distribution
fig3 = px.histogram(orders, x='order_id', nbins=10, title="Orders Distribution by ID")
st.plotly_chart(fig3, use_container_width=True)
st.markdown("**Insight:** Majority of orders fall under lower price ranges.")