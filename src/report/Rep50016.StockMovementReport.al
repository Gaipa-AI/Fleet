report 50016 "Stock Movement Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'StockMvtReport.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Inventory Posting Group";
            DataItemTableView = sorting("No.") where(Type = const(Inventory));

            column(No_; "No.") { }
            column(Description; Description) { }
            column(Base_Unit_of_Measure; "Base Unit of Measure") { }
            column(Item_Category_Code; "Item Category Code") { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(LocationCode; LocationCode) { }
            column(LineNo; LineNo) { }

            // New column for Inventory Posting Group
            column(InventoryPostingGroup; "Inventory Posting Group") { }
            column( InventoryPostingGroupFilter; InventoryPostingGroupFilter){}

            // Stock columns
            column(OpeningStock; OpeningStock) { }
            column(ClosingStock; ClosingStock) { }

            // Inbound columns
            column(PurchaseReceiptQty; PurchaseReceiptQty) { }
            column(PositiveAdjQty; PositiveAdjQty) { }
            column(TransferReceiptQty; TransferReceiptQty) { }
            column(TotalInboundQty; TotalInboundQty) { }

            // Outbound columns
            column(ConsumptionQty; ConsumptionQty) { }
            column(NegativeAdjQty; NegativeAdjQty) { }
            column(TransferShipmentQty; TransferShipmentQty) { }
            column(TotalOutboundQty; TotalOutboundQty) { }

            // Company Info
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(Company_Picture; CompanyInfo.Picture) { }

            trigger OnPreDataItem()
            begin
                LastLineNo := 0; // Initialize at the start
                SetRange("Location Filter", LocationCode);
                SetRange("Date Filter", StartDate, EndDate);

                // Capture the filter from "Inventory Posting Group" if it exists
                if "Inventory Posting Group" <> '' then
                begin
                    SetFilter("Inventory Posting Group", '%1', "Inventory Posting Group"); 
                    InventoryPostingGroupFilter := GETFILTER("Inventory Posting Group");
                end
            end;
        

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
                HasMovement: Boolean;
                ItemRec: Record Item;
            begin
                ClearVariables();
                // Capture the filter value for Inventory Posting Group
                if InventoryPostingGroupFilter = '' then
                    InventoryPostingGroupFilter := GETFILTER("Inventory Posting Group");
                // Check if the item is blocked
                if ItemRec.Get("No.") and ItemRec.Blocked then
                    CurrReport.Skip(); // Skip the current record if the item is blocked

                // Calculate Opening Stock
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Location Code", LocationCode);
                ItemLedgerEntry.SetFilter("Posting Date", '..%1', StartDate - 1);
                if ItemLedgerEntry.FindSet() then
                    repeat
                        OpeningStock += ItemLedgerEntry.Quantity;
                    until ItemLedgerEntry.Next() = 0;

                // INBOUND MOVEMENTS
                // 1. Purchase Receipts
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Location Code", LocationCode);
                ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                if ItemLedgerEntry.FindSet() then
                    repeat
                        PurchaseReceiptQty += ItemLedgerEntry.Quantity;
                    until ItemLedgerEntry.Next() = 0;

                // 2. Positive Adjustments
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Location Code", LocationCode);
                ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
                if ItemLedgerEntry.FindSet() then
                    repeat
                        PositiveAdjQty += ItemLedgerEntry.Quantity;
                    until ItemLedgerEntry.Next() = 0;

                // 3. Transfer Receipts
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Location Code", LocationCode);
                ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Transfer Receipt");
                if ItemLedgerEntry.FindSet() then
                    repeat
                        TransferReceiptQty += ItemLedgerEntry.Quantity;
                    until ItemLedgerEntry.Next() = 0;

                // OUTBOUND MOVEMENTS
                // 1. Consumption
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Location Code", LocationCode);
                ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
                //ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::Consumption);
                if ItemLedgerEntry.FindSet() then
                    repeat
                        ConsumptionQty += ItemLedgerEntry.Quantity;
                    until ItemLedgerEntry.Next() = 0;

                // 2. Negative Adjustments
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Location Code", LocationCode);
                ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::" ");  // Only pure negative adjustments
                if ItemLedgerEntry.FindSet() then
                    repeat
                        NegativeAdjQty += ItemLedgerEntry.Quantity;
                    until ItemLedgerEntry.Next() = 0;

                // 3. Transfer Shipments
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Location Code", LocationCode);
                ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Transfer Shipment");
                if ItemLedgerEntry.FindSet() then
                    repeat
                        TransferShipmentQty += ItemLedgerEntry.Quantity;
                    until ItemLedgerEntry.Next() = 0;

                // Calculate Totals
                TotalInboundQty := PurchaseReceiptQty + PositiveAdjQty + TransferReceiptQty;
                TotalOutboundQty := Abs(ConsumptionQty) + Abs(NegativeAdjQty) + Abs(TransferShipmentQty);

                // Calculate Closing Stock
                ClosingStock := OpeningStock + TotalInboundQty - TotalOutboundQty;

                HasMovement := (PurchaseReceiptQty <> 0) or
                              (PositiveAdjQty <> 0) or
                              (TransferReceiptQty <> 0) or
                              (ConsumptionQty <> 0) or
                              (NegativeAdjQty <> 0) or
                              (TransferShipmentQty <> 0);

                if not HasMovement then
                    CurrReport.Skip()
                else
                begin
                    LastLineNo += 1;  // Only increment for records we're keeping
                    LineNo := LastLineNo;  // Assign the sequential number
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field(LocationCode; LocationCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        TableRelation = Location;
                    }
                  
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        ValidateFilters();
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    local procedure ValidateFilters()
    begin
        if StartDate = 0D then
            Error('Please enter Start Date');
        if EndDate = 0D then
            Error('Please enter End Date');
        if EndDate < StartDate then
            Error('End Date cannot be before Start Date');
        if LocationCode = '' then
            Error('Please select Location');
    end;

    local procedure ClearVariables()
    begin
        Clear(OpeningStock);
        Clear(ClosingStock);
        Clear(PurchaseReceiptQty);
        Clear(PositiveAdjQty);
        Clear(TransferReceiptQty);
        Clear(ConsumptionQty);
        Clear(NegativeAdjQty);
        Clear(TransferShipmentQty);
        Clear(TotalInboundQty);
        Clear(TotalOutboundQty);
    end;

    var
        StartDate: Date;
        EndDate: Date;
        LocationCode: Code[10];
        CompanyInfo: Record "Company Information";
        InventoryPostingGroupFilter: Text;
        OpeningStock: Decimal;
        ClosingStock: Decimal;
        PurchaseReceiptQty: Decimal;
        PositiveAdjQty: Decimal;
        TransferReceiptQty: Decimal;
        ConsumptionQty: Decimal;
        NegativeAdjQty: Decimal;
        TransferShipmentQty: Decimal;
        TotalInboundQty: Decimal;
        TotalOutboundQty: Decimal;
        LineNo: Integer;
        LastLineNo: Integer;  // Added this new variable
}