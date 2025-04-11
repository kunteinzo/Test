import pandas as pd
import re
import json
from pydantic import BaseModel

class Item(BaseModel):
    name: str
    cost: int
    qty: int
    price: int

def csv_to_list(data):
    obj = []
    rows = [l for l in data.strip().split('\n')]
    header = rows[0].split(",")
    for row in rows[1:]:
        it = row.split(",")
        position = 0
        item = {}
        if it[0] == '':
            continue
        for v in it:
            key = header[position]
            val = v.strip()
            if key == 'cpu' or key == 'profit':
                position+=1
                continue
            if re.match(r"^-?\d+\.0$", val):
                val = int(float(val))
            elif re.match(r"^-?\d+\.\d+$", val):
                val = float(val)
            item[key] =  val
            position+= 1
        obj.append(item)
    return obj

try:
    table = pd.read_excel("./python/Table.xlsx", sheet_name="Sheet1")
    print(json.dumps(csv_to_list(table.to_csv(index=False))))
except Exception as e:
    print(f"Error reading the Excel file: {e}")