report 50019 "Fuel Consumption"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'FuelConsumption.rdl';
    Caption = 'Fuel Consumption Report';

    dataset
    {
        dataitem("ADT Requisition Line"; "ADT Requisition Line")
        {
            DataItemTableView = WHERE(Type = FILTER(Item), "No." = FILTER('70061'), "Transferred To Item Jnl" = const(true));
            RequestFilterFields = "Location Code", "Request-By No.", "Equipment No.";

            column(DocumentType_; "Document Type") { }
            column(DocumentNo_; "Document No.") { }
            column(LineNo_; "Line No.") { }
            column(EquipmentNo_; EquipmentNo) { }
            column(EquipmentRegNo_; EquipmentRegNo) { }
            column(EquipmentType_; EquipmentType) { }
            column(EquipmentName_; EquipmentName) { }
            column(LocationCode_; "Location Code") { }
            column(RequestDate_; RequestDate) { }
            column(RequestByNo_; "Request-By No.") { }
            column(RequestByName_; RequestByName) { }
            column(QtyRequested_; "Qty. Requested") { }
            column(UnitCost_; "Unit Cost") { }
            column(TotalCost_; "Total Cost") { }
            column(Description_; Description) { }
            column(UnitOfMeasure_; "Unit of Measure") { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(ReportTitle; ReportTitle) { }
            column(FilterText; FilterText) { }

            trigger OnAfterGetRecord()
            var
                RequisitionHeader: Record "ADT Requisition Header";
                FixedAsset: Record "Fixed Asset";
                Employee: Record Employee;
            begin
                // Get Requisition Header info
                if RequisitionHeader.Get("Document Type", "Request Type", "Document No.") then begin
                    EquipmentNo := RequisitionHeader."Equipment No.";
                    EquipmentRegNo := RequisitionHeader."Equipment RegNo.";
                    EquipmentType := RequisitionHeader."Equipment Type";
                    //EquipmentName := RequisitionHeader."Equipment Name";
                    RequestDate := RequisitionHeader."Order Date";
                end;

                // Get Request-By Name
                if Employee.Get("Request-By No.") then
                    RequestByName := Employee.FullName()
                else
                    RequestByName := '';

                // Accumulate totals
                TotalFuelQty += "Qty. Requested";
                TotalFuelCost += "Total Cost";
                FuelRecordsCount += 1;
            end;

            trigger OnPreDataItem()
            var 
              RequisitionHeader: Record "ADT Requisition Header";
            begin
                FuelRecordsCount := 0;
                TotalFuelQty := 0;
                TotalFuelCost := 0;
                ReportTitle := 'Fuel Consumption Report';
                FilterText := '  Equipment No: ' + "ADT Requisition Line".GetFilter("Equipment No.")+
                              ' | Location: ' + "ADT Requisition Line".GetFilter("Location Code") +
                              ' | Request-By: ' + "ADT Requisition Line".GetFilter("Request-By No.") ;

                // Filter by Order Date (Request Date) range
                if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then begin
                    RequisitionHeader.SetRange("Order Date", FromDateFilter, ToDateFilter);
                end;
                    //"ADT Requisition Line".SetRange("Order Date", FromDateFilter, ToDateFilter);
                    // Note: We'll need to handle the date range via the header filtering
                
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
                    Caption = 'Filters';
                    field(LocationCodeFilter; LocationCodeFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Location Code';
                        TableRelation = Location.Code;
                    }
                    field(EquipmentNoFilter; EquipmentNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Equipment No.';
                        TableRelation = "Fixed Asset"."No.";
                    }
                    field(FromDateFilter; FromDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date (Request Date)';
                    }
                    field(ToDateFilter; ToDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date (Request Date)';
                    }
                    field(RequestByNoFilter; RequestByNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Request-By No. (Driver)';
                        TableRelation = Employee."No.";
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPreReport()
    var
        RequisitionHeader: Record "ADT Requisition Header";
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        // Apply filters to the main dataitem based on request page inputs
        if LocationCodeFilter <> '' then
            "ADT Requisition Line".SetRange("Location Code", LocationCodeFilter);

        if RequestByNoFilter <> '' then
            "ADT Requisition Line".SetRange("Request-By No.", RequestByNoFilter);

        if EquipmentNoFilter <> '' then
            "ADT Requisition Line".SetRange("Equipment No.", EquipmentNoFilter);


        // Filter by Order Date (Request Date) range
        // if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then begin
        //     RequisitionHeader.SetRange("Order Date", FromDateFilter, ToDateFilter);
            //"ADT Requisition Line".SetRange("Order Date", FromDateFilter, ToDateFilter);
            // Note: We'll need to handle the date range via the header filtering
        //end;
    end;

    trigger OnPostReport()
    begin
        // Optional: Post-report logic
    end;

    var
        CompanyInfo: Record "Company Information";
        LocationCodeFilter: Code[10];
        EquipmentNoFilter: Code[20];
        FromDateFilter: Date;
        ToDateFilter: Date;
        RequestByNoFilter: Code[20];
        EquipmentNo: Code[20];
        EquipmentRegNo: Code[30];
        EquipmentType: Code[100];
        EquipmentName: Text[100];
        RequestDate: Date;
        RequestByName: Text[100];
        TotalFuelQty: Decimal;
        TotalFuelCost: Decimal;
        FuelRecordsCount: Integer;
        ReportTitle: Text[100];
        FilterText: Text[500];
}