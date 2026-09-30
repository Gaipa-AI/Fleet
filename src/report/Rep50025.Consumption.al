report 50025 Consumption
{
    ApplicationArea = All;
    Caption = 'Consumption';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem(ADTRequisitionHeader; "ADT Requisition Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST("Store Requisition"),
                                    "Request Type" = CONST(Fuel),
                                      "No." = FILTER(<> ''));
            RequestFilterFields = "Document Type", "No.", "Request-By No.";
            column(No; "No.")
            {
            }
            column(RequestByNo; "Request-By No.")
            {
            }
            column(RequestByName; "Request-By Name")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(EquipmentNo; "Equipment No.")
            {
            }
            column(EquipmentRegNo; "Equipment RegNo.")
            {
            }
            column(EquipmentType; "Equipment Type")
            {
            }
            column(DriverNo; "Driver No.")
            {
            }
            column(DriverName; "Driver Name")
            {
            }
            column(PostingDescription; "Posting Description")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(Preparedby; "Prepared by")
            {
            }
            column(CurrentApprover; "Current Approver")
            {
            }
            column(Status; Status) { }

            column(Transferred; Transferred) { }

            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Company_Address;CompanyInfo.Address) { }
            column(CompanyInformation_Email; CompanyInfo."E-Mail")
            {

            }
            column(CompanyInformation_Phone; CompanyInfo."Phone No.")
            {

            }
            column(CompanyInformation_Home; CompanyInfo."Home Page")
            {

            }


            dataitem("Consumption Line"; "ADT Requisition Line")
            {
                DataItemLinkReference = "ADTRequisitionHeader";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(Consumption_Type; Type)
                {
                }
                column(ItemNo;"No.")
                {
                }
                column(Item_Category_Code;"Item Category Code")
                {
                }
                
                column(DocumentNo;"Document No.")
                {
                }
                column(Description;Description)
                {
                }
               
                
                column(UnitofMeasureCode;"Unit of Measure Code")
                {
                }
                column(Quantity_Requested;"Qty. Requested")
                {
                }
                column(RequireQuantity;"Quantity")
                {
                }
                
                column(ConsumedQuantity;"Total Qty To Item Jnl")
                {
                }
                
                column(LineNo;LineNo)
                {
                }

                trigger OnAfterGetRecord()begin
                    LineNo:=LineNo + 1; // Increment the line number for each record
                    
                    
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
                group(MyReport)
                {

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
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Consumption.rdl';
        }
    }

    var
        CompanyInfo: Record "Company Information";
        ReportTitle: Text[100];
        LineNo: Integer;


    trigger OnInitReport()begin
        LineNo:=0;
        
    end;



    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;
     
}
