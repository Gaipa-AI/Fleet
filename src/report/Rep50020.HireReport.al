report 50020 "Equipment Hire Jobs Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'EquipmentHireJobsReport.rdl';
    Caption = 'Equipment Hire Jobs Report';

    dataset
    {
        dataitem("Form Header"; "Form Header")
        {
                DataItemTableView = 
                //SORTING("Equipment No.")
                WHERE("Document Type" = FILTER("Internal Hire"|"External Hire"), Converted = const(true));

                RequestFilterFields = "Document Type","No.";

            
            column(JobLocation; "Job Location") { }
            column(DocumentNo; "No.") { }
            column(DocumentDate; Date) { }
            column(HireRate; "Hire Rate") { }
            column(Quantity; Quantity) { }
            column(TermsOfHire; TermsOfHire) { }
            column(EstimatedCost; EstimatedHireCost) { }

           

            // trigger OnAfterGetRecord()
            // begin
            //     TermsOfHire := GetTermsOfHireText();
            //     EstimatedCost := CalculateEstimatedCost();
            //     //JobCount := GetEquipmentJobCount(Rec."Equipment No.");
            // end;
            dataitem("Form Line"; "Form Line")
            {
                DataItemLink = 
                    "Document Type" = FIELD("Document Type"),
                    "Document No." = FIELD("No.");

                column(EquipmentNo; "Equipment No.") { }
                column(EquipmentRegNo; "Equipment RegNo") { }
                column(EquipmentType; "Equipment Type") { }
                column(EquipmentName; "Equipment Name") { }

                trigger OnPreDataItem()
                begin
                    if EquipmentNoFilter <> '' then
                        "Form Line".SetRange("Equipment No.", EquipmentNoFilter);
                end;

            }
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
        // if EquipmentNoFilter <> '' then
        //     "Form Header".SetRange("Equipment No.", EquipmentNoFilter);

        if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then
            "Form Header".SetRange(Date, FromDateFilter, ToDateFilter);
    end;

    var
        EquipmentNoFilter: Code[20];
        FromDateFilter: Date;
        ToDateFilter: Date;
        HireFilter: Option "","Internal Hire","External Hire";
        TermsOfHire: Text[100];
        EstimatedCost: Decimal;
        JobCount: Integer;
        
}