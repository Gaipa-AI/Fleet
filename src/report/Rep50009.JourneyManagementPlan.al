report 50009 "Journey Management Plan"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Form Header"; "Form Header")
        {
            DataItemTableView = where("Document Type" = filter("Journey Management Plan"));
            column(No_; "No.") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Site_Name; "Site Name") { }
            column(Validity_Daily; "Validity Date") { }
            column(Validity; Validity) { }
            column(From_Date; "From Date") { }
            column(To_Date; "To Date") { }
            column(JMP_Requester_Name; "JMP Requester Name") { }
            column(JMP_User_Name; "JMP User Name") { }
            column(Department; Department) { }
            column(Point_Of_Departure; "Point Of Departure") { }
            column(Departure_Time; "Departure Time") { }
            column(Destination; Destination) { }
            column(Planned_Date_of_Return; "Planned Date of Return") { }
            column(Distance; Distance) { }
            column(Black_Top_Road; "Black Top Road") { }
            column(Murram_Road; "Murram Road") { }
            column(Stop_Over; "Stop Over") { }
            column(Personnel_Transport; "Personnel Transport") { }
            column(Material_Transport; "Material Transport") { }
            column(Food_Delivery; "Food Delivery") { }
            column(Other; Other) { }
            column(Driver_Name; "Driver Name") { }
            column(Driver_s_Contact; "Driver's Contact") { }
            column(Equipment_Type; "Equipment Type") { }
            column(License_Expiry_Date; "License Expiry Date") { }
            column(Last_Vehicle_Inspection; "Last Vehicle Inspection") { }
            column(Equipment_RegNo; "Equipment RegNo") { }
            column(NumberOfPassengers_FormHeader; "Number Of Passengers")
            {
            }
            column(NumberOfUgandanCitizens_FormHeader; "Number Of Ugandan Citizens")
            {
            }
            column(NumberOfResidentForeigners_FormHeader; "Number of Resident Foreigners")
            {
            }
            column(NumberOfNonResidentForeigners_FormHeader; "NumberOf NonResidentForeigners")
            {
            }
            column(RiskAssessment_FormHeader; "Risk Assessment")
            {
            }
            column(RiskLevel_FormHeader; "Risk Level")
            {
            }
            column(HSEInduction_FormHeader; "HSE Induction")
            {
            }
            column(Status_FormHeader; Status)
            {
            }
            column(Approver; "Current Approver"){}

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
            LayoutFile = 'JourneyManagementPlan.rdl';
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