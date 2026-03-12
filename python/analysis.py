import pandas as pd

projects=pd.read_csv("projects.csv")
materials=pd.read_csv("material_purchase.csv")
labours=pd.read_csv("daily_labour.csv")
contract=pd.read_csv("contract_work.csv")
contractor=pd.read_csv("contractor_payment.csv")
customer=pd.read_csv("customer_payment.csv")




date_cols_projects =["start_date","planed_end_date","actual_end_date"] 
for col in date_cols_projects:
    projects[col]=pd.to_datetime(projects[col], errors="coerce")

materials["purchase_date"]=pd.to_datetime(materials["purchase_date"])
labours["work_date"]=pd.to_datetime(labours["work_date"])
customer["payment_date"]=pd.to_datetime(customer["payment_date"])
contractor["payment_date"]=pd.to_datetime(contractor["payment_date"])

date_cols_contract=["start_date","end_date"]
for col in date_cols_contract:
    contract[col]=pd.to_datetime(contract[col])


print(projects.head(2))
print(materials.head(2))
print(labours.head(2))
print(contract.head(2))
print(contractor.head(2))
print(customer.head(2))

mat_cost=materials.groupby("project_id")["total_cost"].sum()
lab_cost=labours.groupby("project_id")["daily_wage"].sum()
cont_cost=contract.groupby("project_id")["contract_amount"].sum()

cost_df=pd.concat([mat_cost,lab_cost,cont_cost],axis=1).fillna(0)
cost_df.columns=["material_cost","labour_cost","contract_cost"]

print(cost_df.head())

project_summary=projects.merge(cost_df,on="project_id",how="left")

project_summary["total_spent"]=(
    project_summary["material_cost"]+
    project_summary["labour_cost"]+
    project_summary["contract_cost"]
)
project_summary["profit"]=(project_summary["total_contract_amount"]-project_summary["total_spent"])

print(project_summary[[
    "project_id",
    "total_contract_amount",
    "material_cost",
    "labour_cost",
    "contract_cost",
    "total_spent",
    "profit"
]].head())

project_summary.to_csv("project_summary.csv",index=False)
print("project_summary.csv created")

import matplotlib.pyplot as plt

materials["month"]=materials["purchase_date"].dt.to_period("M")

monthly_material_cost=materials.groupby("month")["total_cost"].sum()

monthly_material_cost.plot(kind="line", title="Monthly_Material_Cost_Trend")
plt.xlabel("Month")
plt.ylabel("Material_cost")
plt.tight_layout()
plt.show()

project_summary_sorted=project_summary.sort_values("profit" ,ascending=False)
project_summary_sorted.plot(
    x="project_id",
    y="profit",
    kind="bar",
    title="Profit per Projet",
    legend=False
)
plt.xlabel("Project ID")
plt.ylabel("Profit")
plt.tight_layout()
plt.show()

project_summary_sorted.to_csv("project_summary_sorted.csv",index=False)
monthly_material_cost.to_csv("monthly_material_cost.csv",index=False)
print("project_summary_sorted.csv and monthly_material_cost.csv cfreated")