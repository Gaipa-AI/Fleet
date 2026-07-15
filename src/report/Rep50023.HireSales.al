report 50023 HireSales
{
    ApplicationArea = All;
    Caption = 'HireSales';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'HireSales.rdl';
    
    dataset
    {
        dataitem("Sales Header"; "Sales Invoice Header")
        {
            DataItemTableView = 
                
                WHERE("Hire Request No." = filter(<>''));
            
            // column(DocumentNo; "Equipment Hire No."){ }
            column(DocumentNo; "Hire Request No."){ }
            column(EquipmentType; "Equipment Type") { }
            column(Equipment_No_;"Equipment No."){ }
            column(Equipment_Name;"Equipment Name"){ }
           
            column(CustomerNo; "Sell-to Customer No."){ }
            column(CustomerName; "Sell-to Customer Name"){ }
            column(Document_Date;"Document Date"){ }
            column(Equipment_Type;"Equipment Type"){ }
            column(Equipment_Hire_No_;"Equipment Hire No."){ } 
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }

            column(ReportTitle; ReportTitle) { }
            

            dataitem("Sales Line";"Sales Invoice Line")
            {
                DataItemLink = 
                    "Document No." = FIELD("No.");

                column(Description;Description){ }
                column(Quantity;Quantity){ } 
                column(Line_Amount;"Line Amount"){ }
               

            }
            
            trigger OnPreDataItem()
                begin
                    ReportTitle := 'Hiring Sales Report';
                    
                    if (FromDateFilter <> 0D) and (ToDateFilter <> 0D) then
                       "Sales Header".SetRange("Document Date", FromDateFilter, ToDateFilter);

                    if EquipmentNoFilter <> '' then
                    "Sales Header".SetRange("Equipment No.", EquipmentNoFilter);
   
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
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
       
    end;

    var
        CompanyInfo: Record "Company Information";
        EquipmentNoFilter: Code[20];
        FromDateFilter: Date;
        ToDateFilter: Date;  
        ReportTitle: Text;
}
