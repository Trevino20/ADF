# ER Diagram - Material Flow

```mermaid
erDiagram
    EventsData {
        string Item_Material_ID
        string Item_Name
    }

    MaterialMaster {
        string Material_Code
        string MaterialGroup
        float Width
        float Thickness
    }

    ProductMaster {
        string Material_Group_Number
        string Product
    }

    DimMaterial_OB {
        string MaterialCode
        string Product
        float Width
        float Thickness
    }

    EventsData ||--o{ MaterialMaster : "Item Material ID = Material Code"
    MaterialMaster }o--|| ProductMaster : "MaterialGroup = Material Group Number"
    MaterialMaster ||--o{ DimMaterial_OB : "Insert if not exists"
    