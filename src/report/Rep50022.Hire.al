report 50022 "Hire Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'HireReport.rdl';
    Caption = 'Hire Report';

    dataset
    {
        dataitem("Form Line"; "Form Line")
        {
                DataItemTableView = 
                //SORTING("Equipment No.")
                WHERE("Document Type" = FILTER("Internal Hire"|"External Hire"));

                RequestFilterFields = "Document Type","Document No.", "Equipment No.";
                column(EquipmentNo; "Equipment No.") { }
                column(EquipmentRegNo; "Equipment RegNo") { }
                column(EquipmentType; "Equipment Type") { }
                column(EquipmentName; "Equipment Name") { }

                column(CompanyInfo_Picture; CompanyInfo.Picture) { }
                column(CompanyInfo_Name; CompanyInfo.Name) { }
                column(CompanyInfo_Address; CompanyInfo.Address) { }
                column(ReportTitle; ReportTitle) { }
                //column(PreparedBy;"")

                
                
            
            column(JobLocation; "Job Location") { }
            
            dataitem("Form Header"; "Form Header")
            {
                DataItemLink = 
                    "Document Type" = FIELD("Document Type"),
                    "No." = FIELD("Document No.");

                column(DocumentNo; "No.") { }
                column(DocumentDate; Date) { }
                column(HireRate; "Hire Rate") { }
                column(Quantity; Quantity) { }

                column(TermsOfHire; TermsOfHire) { }
                column(EstimatedCost; EstimatedHireCost) { }
                column(HireDays;"Hire Days"){ }
                column(User; "Prepared by") { }

                //column(Approver;""){}

            trigger OnAfterGetRecord()
            begin
                
            end;


            }
            trigger OnPreDataItem()
                begin
                    ReportTitle := 'Hiring Report';
                    
                    if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then
                       "Form Header".SetRange(Date, FromDateFilter, ToDateFilter);
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
            "Form Header".SetRange("Equipment No.", EquipmentNoFilter);

        if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then
            "Form Header".SetRange(Date, FromDateFilter, ToDateFilter);
    end;

    
    var
        CompanyInfo: Record "Company Information";
        EquipmentNoFilter: Code[20];
        FromDateFilter: Date;
        ToDateFilter: Date;
        HireFilter: Option "","Internal Hire","External Hire";
        
        ReportTitle: Text;
}