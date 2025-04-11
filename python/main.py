import pandas as pd
import re
from pydantic import BaseModel

print("Hello world")

class Item(BaseModel):
    name: str
    cost: int
    qty: int
    price: int
    cpu: float
    profit: float

def csv_to_list(data):
    obj = []
    rows = [l for l in data.strip().split('\n')]
    header = rows[0].split(",")
    for row in rows[1:]:
        it = row.split(",")
        h = 0
        item = {}
        if it[0] == '':
            continue
        for v in row.split(","):
            val = v
            if re.match(r"^-?\d+\.0$", val):
                val = int(float(val))
            elif re.match(r"^-?\d+\.\d+$", val):
                val = float(val)
            item[header[h]] =  val
            h+= 1
        obj.append(Item(**item))
    return obj

try:
    table = pd.read_excel("./Table.xlsx", sheet_name="Sheet1")
    print(csv_to_list(table.to_csv(index=False)))
except Exception as e:
    print(f"Error reading the Excel file: {e}")