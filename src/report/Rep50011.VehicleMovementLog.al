report 50011 "Vehicle Movement Log"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Form Header"; "Form Header")
        {
            DataItemTableView = where("Document Type" = const("Vehicle Movement Log"));
            column(No_; "No.") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Client_Name; "Client Name") { }
            column(Equipment_No_; "Equipment No.") { }
            column(Equipment_RegNo; "Equipment RegNo") { }

            dataitem("Form Line"; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document No." = FIELD("No.");
                column(Date; Date) { }
                column(Driver_Name; "Driver Name") { }
                column(Opening_Mileage; "Opening Mileage") { }
                column(Closing_Mileage; "Closing Mileage") { }
                column(From; From) { }
                column(Destination; Destination) { }
                column(Fuel_Top_up__Liters_; "Fuel Top-up (Liters)") { }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'VehicleMovementLog.rdl';
        }
    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}