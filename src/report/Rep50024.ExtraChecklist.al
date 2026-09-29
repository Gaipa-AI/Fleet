report 50024 "Extra Checklist"
{
    ApplicationArea = All;
    Caption = 'Extra Checklist';
    UsageCategory = ReportsAndAnalysis;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Form Header"; "Form Header")
        {
            DataItemTableView = where("Document Type" = filter("Equipment Inspection"));

            column(No_; "No.") { }
            column(Operator_No_; "Driver No.") { }
            column(Operator_Name; "Driver Name") { }
            column(Week_Start_Km_s; "Week Start Km's") { }
            column(Week_End_Km_s; "Week End Km's") { }
            column(Week_Start_Date; "Week Start Date") { }
            column(Department; Department) { }
            column(Site_Location; "Crew Location") { }
            column(Equipment_No_; "Equipment No.") { }
            column(Equipment_RegNo; "Equipment RegNo") { }
            column(Equipment_Make; "Equipment Make") { }
            column(Equipment_Name; "Equipment Name") { }
            
            column(License_Expiry_Date; "License Expiry Date") { }
            column(Next_Service_at_Mileage; "Next Service at Mileage") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Inspection_Type; "Inspection Type") { }
            column(ReportTitle; ReportTitle) { }
            column(State; State) { }
            column(Current_Approver;"Current Approver") { }
            column(Prepared_by;"Prepared by") { }

            column(Current_Hours;"Current Hours") { }
            column(Technician; Technician) { }
            column(Technician_Name; "Technician's Name") { }

            dataitem(General; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = where(Sections = filter("General"));

                column(General_Description; Description) { }
                column(General_Details; Details) { }
                column(General_Monday; Monday) { }
                column(General_Tuesday; Tuesday) { }
                column(General_Wednesday; Wednesday) { }
                column(General_Thursday; Thursday) { }
                column(General_Friday; Friday) { }
                column(General_Saturday; Saturday) { }
                column(General_Sunday; Sunday) { }
                column(General_Comment; Comment) { }
                column(General_Status; General_Status) { }



                trigger OnAfterGetRecord()
                begin
                    General_Status := false;
                    //if General.Monday or 
                    if General.Missing or General.Damaged or General.Tuesday or General.Wednesday or General.Thursday or General.Friday or General.Saturday or General.Sunday then
                       General_Status := true;
                    // General_Status := true;
                end;

                trigger OnPreDataItem()
                begin
                    General_Status := false;
                end;
            }


            trigger OnAfterGetRecord()
            begin
                if "Form Header"."Equipment Type" = 'TRUCKS' then ReportTitle := 'SELF LOADER INSPECTION CHECKLIST'
                else if "Form Header"."Equipment Type" = 'VEHICLES' then ReportTitle := 'DAILY INSPECTION CHECKLIST';
            end;


        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
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
            LayoutFile = 'DailyInspection.rdl';
        }
    }

    var
        CompanyInfo: Record "Company Information";
        ReportTitle: Text[100];
        General_Status: Boolean;
        

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;
}
