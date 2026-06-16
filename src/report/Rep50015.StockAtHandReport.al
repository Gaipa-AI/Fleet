report 50015 "Stock At Hand Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'stock.rdl';
    Caption = 'Stock At Hand';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = where(Blocked = const(false));
            RequestFilterFields = "No.", "Inventory Posting Group";

            column(ItemNo; "No.") { }
            column(Item_Name; Description) { }
            column(Item_Category_Code; "Item Category Code") { }
            column(Base_Unit_Of_Measure; "Base Unit Of Measure") { }
            column(Inventory_Posting_Group; "Inventory Posting Group") { }
            column(LocationCode; LocationFilter) { }
            column(CurrentQty; CurrentQty) { }
            column(InventoryPostingGroupFilterTxt; InventoryPostingGroupFilterTxt) { }
            column(AsAtDateTxt; Format(AsAtDate)) { }

            trigger OnPreDataItem()
            begin
                if LocationFilter = '' then
                    Error('Location Code filter is mandatory.');

                InventoryPostingGroupFilterTxt := GetFilter("Inventory Posting Group");
            end;

            trigger OnAfterGetRecord()
            var
                ILE: Record "Item Ledger Entry";
            begin
                CurrentQty := 0;

                ILE.Reset();
                ILE.SetRange("Item No.", "No.");
                ILE.SetRange("Location Code", LocationFilter);

                if AsAtDate <> 0D then
                    ILE.SetFilter("Posting Date", '..%1', AsAtDate);

                if "Inventory Posting Group" <> '' then
                    //ILE.SetRange("Inventory Group", "Inventory Posting Group");

                if ILE.FindSet() then
                    repeat
                        // Use Quantity for true historical accuracy
                        CurrentQty += ILE.Quantity;
                    until ILE.Next() = 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(LocationFilter; LocationFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Location Code';
                        TableRelation = Location;
                    }

                    field(AsAtDate; AsAtDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Stock As At Date';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if AsAtDate = 0D then
            AsAtDate := WorkDate();
    end;

    var
        CurrentQty: Decimal;
        LocationFilter: Code[10];
        InventoryPostingGroupFilterTxt: Text;
        AsAtDate: Date;
}
