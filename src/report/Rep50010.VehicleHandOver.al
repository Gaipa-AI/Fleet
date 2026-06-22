report 50010 "Vehicle Hand Over"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    Caption = 'Vehicle/Plant Hand Over Report';

    dataset
    {
        dataitem("Form Header"; "Form Header")
        {
            DataItemTableView = where("Document Type" = filter("Equipment Hand Over"));
            column(No_; "No.") { }
            column(Date; Date) { }
            column(Time; Time) { }
            column(Former_Driver_Name; "Former Driver Name") { }
            column(Assigned_Driver_Name; "Assigned Driver Name") { }
            column(Equipment_No_; "Equipment No.") { }
            column(Equipment_RegNo; "Equipment RegNo") { }
            column(Equipment_Type; "Equipment Type") { }
            column(Any_Dents; "Any Dents") { }
            column(Dents_Description; "Dents Description") { }
            column(Any_Scratches; "Any Scratches") { }
            column(Scratches_Description; "Scratches Description") { }
            column(Interior_Condition; "Interior Condition") { }
            column(Interior_Remarks; "Interior Remarks") { }
            column(General_Mechanical_Condition; "General Mechanical Condition") { }
            column(Mechanical_Remarks; "Mechanical Remarks") { }
            column(Fuel_Level; "Fuel Level") { }
            column(Odometer_Reading; "Odometer Reading") { }
            column(Next_Service; "Next Service") { }
            column(Driver_s_License; "Driver's License") { }
            column(Defensive_Driving_Certificate; "Defensive Driving Certificate") { }
            column(Medical_Fitness_Certificate; "Medical Fitness Certificate") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Prepared_by;"Prepared by"){ }

            dataitem("Form Line"; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Document Type" = filter("Equipment Hand Over"));
                column(Items_Present; "Items Present") { }
                column(Present; Present) { }
                column(Missing; Missing) { }
                column(Damaged; Damaged) { }
                column(Remarks; Remarks) { }
            }
            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where(status = filter(Approved));
                column(Approver_Id; "Approver ID") { }
                column(Escalated_Id; "Escalated By") { }
                column(LastDateTimeModified; "Last Date-Time Modified") { }
                column(ApproverName; ApproverName) { }
                trigger OnAfterGetRecord()
                var
                    User: Record User;
                begin
                    User.Reset();
                    User.SetRange("User Name", "Approver ID");
                    if User.FindFirst() then
                        ApproverName := User."Full Name";
                end;
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'VehicleHandOver.rdl';
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ApproverName: Text;
}