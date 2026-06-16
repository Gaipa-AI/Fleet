report 50021 "Repair Cost Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'RepairCostReport.rdl';
    Caption = 'Repair Cost Report';

    dataset
    {
        dataitem("ADT Requisition Header"; "ADT Requisition Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER("Purchase Requisition"),
                                      "Request Type" = FILTER("Spare Parts"));

            RequestFilterFields = "Equipment No.", "Equipment Type";
            // "Job Card No.", "Posting Date";

            column(EquipmentNo; "Equipment No.")
            {
            }
            column(EquipmentType; "Equipment Type")
            {
            }
            column(EquipmentRegNo; "Equipment RegNo.")
            {
            }
            column(JobCardNo; "Job Card No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(TotalCost; "Requisition Lines Total")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(ReportTitle; ReportTitle) { }

            dataitem("Maintenance Header"; "Maintenance Header")
            {
                DataItemLink = "No." = FIELD("Job Card No.");
                DataItemTableView = WHERE("Document Type" = FILTER("Job Card"),
                                          "Job Status" = FILTER(Closed));

                column(JobStatus; "Job Status")
                {
                }
                column(Equipment_Name;"Equipment Name"){}
            }

            trigger OnPreDataItem()
            begin
                ReportTitle := 'Repair Cost Report';
                 if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then
                    "ADT Requisition Header".SetRange("Posting Date", FromDateFilter, ToDateFilter);
     
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
                    field(EquipmentNoFilter; EquipmentNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Equipment No.';
                        TableRelation = "Fixed Asset"."No.";
                    }
                    field(EquipmentTypeFilter; EquipmentTypeFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Equipment Type';
                        TableRelation = "General value".Code where(Type = const("Equipment Type"));
                    }
                    
                    field(FromDateFilter; FromDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                    }
                    field(ToDateFilter; ToDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        if EquipmentNoFilter <> '' then
            "ADT Requisition Header".SetRange("Equipment No.", EquipmentNoFilter);

        if EquipmentTypeFilter <> '' then
            "ADT Requisition Header".SetRange("Equipment Type", EquipmentTypeFilter);

        if JobCardNoFilter <> '' then
            "ADT Requisition Header".SetRange("Job Card No.", JobCardNoFilter);
        if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then
                "ADT Requisition Header".SetFilter("Posting Date", '%1..%2', FromDateFilter, ToDateFilter)
            else
                if FromDateFilter <> 0D then
                    "ADT Requisition Header".SetRange("Posting Date", FromDateFilter, 20180325D)
                else
                    if ToDateFilter <> 0D then
                        "ADT Requisition Header".SetRange("Posting Date", 0D, ToDateFilter);
     end;

    var
        EquipmentNoFilter: Code[20];
        EquipmentTypeFilter: Code[20];
        JobCardNoFilter: Code[20];
        FromDateFilter: Date;
        ToDateFilter: Date;
        ReportTitle: Text[100];
        CompanyInfo: Record "Company Information";
}