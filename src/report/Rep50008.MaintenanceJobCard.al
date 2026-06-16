report 50008 "Maintenance Job Card"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Maintenance Header"; "Maintenance Header")
        {
            DataItemTableView = sorting("No.") where("Document Type" = filter("Job Card"));
            column(MaintenanceNo; "Maintenance Header"."No.") { }
            column(Equipment_No_; "Equipment No.") { }
            column(Equipment_Make; "Equipment Make") { }
            column(Odometer_Reading__Km_Hrs_; "Odometer Reading (Km/Hrs)") { }
            column(Maintenance_Request_No_; "Maintenance Request No.") { }
            column(Maintenance_Request_Date; "Maintenance Request Date") { }
            column(Driver_No_; "Driver No.") { }
            column(Driver_Name; "Driver Name") { }
            column(Posting_Date; "Posting Date") { }
            column(Requester_Name; "Requester Name") { }
            column(Requester_No_; "Requester No.") { }
            column(Status; Status) { }
            column(Report_Summary; "Report Summary") { }
            column(Other_Comments; "Other Comments") { }
            column(Mechanic_Name; "Mechanic Name") { }
            column(Workshop_Manager_Name; "Workshop Manager Name") { }
            column(Remarks; Remarks) { }

            dataitem("Maintenance Line"; "Maintenance Line")
            {
                DataItemLinkReference = "Maintenance Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");

                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                column(Unit_Cost; "Unit Cost") { }
                column(Amount; Amount) { }
                column(Source; Source) { }
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
            LayoutFile = 'MaintenanceJobCard.rdl';
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