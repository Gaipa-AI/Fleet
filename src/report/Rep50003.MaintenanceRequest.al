report 50003 "Maintenance Request"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Maintenance Header"; "Maintenance Header")
        {
            DataItemTableView = sorting("No.") where("Document Type" = filter("Maintenance Request"));
            RequestFilterFields= "No.";
            column(MaintenanceNo; "Maintenance Header"."No.") { }
            column(Equipment_No_; "Equipment No.") { }
            column(Equipment_Make; "Equipment Make") { }
            column(Odometer_Reading__Km_Hrs_; "Odometer Reading (Km/Hrs)") { }
            column(Driver_No_; "Driver No.") { }
            column(Driver_Name; "Driver Name") { }
            column(Posting_Date; "Posting Date") { }
            column(Request_Summary; "Request Summary") { }
            column(Description_of_Problem; "Description of Problem") { }
            column(Requester_Name; "Requester Name") { }
            column(Requester_No_; "Requester No.") { }
            column(Status; Status) { }
            column(CheckList_No; "CheckList No.") { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Approver; "Current Approver"){ }

            dataitem("Maintenance Line"; "Maintenance Line")
            {
                DataItemLinkReference = "Maintenance Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");

                column(No_; "No.") { }
                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(LinesCount; LinesCount) { }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    LinesCount := LinesCount + 1;
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
                
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'MaintenanceRequest.rdl';
        }
    }

    var
        Name: Text;
        LinesCount: Integer;
        CompanyInfo: Record "Company Information";

    trigger OnPreReport()
    begin
        LinesCount := 0;
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;
}