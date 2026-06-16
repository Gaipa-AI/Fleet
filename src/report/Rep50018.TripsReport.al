report 50018 "Trips Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'TripsReport.rdl';
    Caption = 'Trips Report';

    dataset
    {
        dataitem("Form Header"; "Form Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER("Journey Management Plan"), Status = FILTER(Released), "Journey Ended" = const(true));
            RequestFilterFields = "Equipment No.", "From Date", "To Date";

            column(No_; "No.") { }
            column(EquipmentNo_; "Equipment No.") { }
            column(EquipmentName_; "Equipment Name") { }
            column(EquipmentRegNo_; "Equipment RegNo") { }
            column(EquipmentType_; "Equipment Type") { }
            column(EquipmentMake_; "Equipment Make") { }
            column(EquipmentModel_; "Equipment Model") { }
            column(Distance_; Distance) { }
            column(Hours_; "Hours") { }
            column(Days_; Days) { }
            column(FromDate_; "From Date") { }
            column(ToDate_; "To Date") { }
            column(DriverNo_; "JMP User No.") { }
            column(DriverName_; "JMP User Name") { }
            column(Status_; Status) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(ReportTitle; ReportTitle) { }
            column(FilterText; FilterText) { }

            trigger OnAfterGetRecord()
            begin
                TotalKMCovered += Distance;
                TotalHoursDriven += "Hours";
                TotalDaysWorked += Days;
                TripsCount += 1;
            end;

            trigger OnPreDataItem()
            begin
                TripsCount := 0;
                TotalKMCovered := 0;
                TotalHoursDriven := 0;
                TotalDaysWorked := 0;
                ReportTitle := 'Trips Report';
                FilterText := 'Equipment: ' + "Form Header".GetFilter("Equipment No.") + 
                              ' | From Date: ' + Format("Form Header".GetFilter("From Date")) + 
                              ' | To Date: ' + Format("Form Header".GetFilter("To Date"));

                if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then
                 "Form Header".SetRange("From Date", FromDateFilter, ToDateFilter);
                if EquipmentNoFilter <> '' then
                 "Form Header".SetRange("Equipment No.", EquipmentNoFilter);
                 
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
                    field(EquipmentNo; EquipmentNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Equipment No.';
                        TableRelation = "Fixed Asset"."No.";
                    }
                    field(FromDate; FromDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                    }
                    field(ToDate; ToDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then
            "Form Header".SetRange("From Date", FromDateFilter, ToDateFilter);
        if EquipmentNoFilter <> '' then
            "Form Header".SetRange("Equipment No.", EquipmentNoFilter);
    end;

    trigger OnPostReport()
    begin
        // Optional: Post-report logic
    end;

    var
        CompanyInfo: Record "Company Information";
        EquipmentNoFilter: Code[20];
        FromDateFilter: Date;
        ToDateFilter: Date;
        TotalKMCovered: Decimal;
        TotalHoursDriven: Decimal;
        TotalDaysWorked: Integer;
        TripsCount: Integer;
        ReportTitle: Text[100];
        FilterText: Text[500];
}