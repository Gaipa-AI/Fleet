report 50006 "Hire Request"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Form Header"; "Form Header")
        {
            column(No_; "No.") { }
            column(Client_No_; "Client No.") { }
            column(Client_Name; "Client Name") { }
            column(Equipment_Type; "Equipment Type") { }
            column(Date; Date) { }
            column(Address; Address) { }
            column(Address_2; "Address 2") { }
            column(Quantity; Quantity) { }
            column(Job_Location; "Job Location") { }
            column(Job_Start_Date; "Job Start Date") { }
            column(Job_End_Date; "Job End Date") { }
            column(Client_Category; "Client Category") { }
            column(Contact_Person_Name; "Contact Person Name") { }
            column(Contact_Person_Email; "Contact Person Email") { }
            column(Contact_Person_Contact; "Contact Person Contact") { }
            column(Hourly_Rate; "Hourly Rate") { }
            column(Daily; Daily) { }
            column(Monthly; Monthly) { }
            column(Dry_Hire; "Dry Hire") { }
            column(Wet_Hire; "Wet Hire") { }
            column(Per_Trip; "Per Trip") { }
            column(Other; Other) { }
            column(Currency; Currency) { }
            column(Hire_Rate; "Hire Rate") { }
            column(Payment_Terms; "Payment Terms") { }
            column(Prepared_by; "Prepared by") { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
            column(Authorized_By; "Authorized By") { }
            column(PaymentTermDescription; PaymentTermDescription) { }
            column(ReportTitle; ReportTitle) { }

            dataitem(Lines; "Form Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document No." = FIELD("No.");

                column(Equipment_No_Lines; Lines."Equipment No.") { }
                column(Equipment_Name_Lines; Lines."Equipment Name") { }
                column(Equipment_Make_Lines; Lines."Equipment Make") { }
                column(Equipment_Model_Lines; Lines."Equipment Model") { }
                column(Equipment_RegNo_Lines; Lines."Equipment RegNo") { }
                column(Equipment_Serial_No__Lines; Lines."Equipment Serial No.") { }
                column(Equipment_Type_Lines; Lines."Equipment Type") { }
            }

            dataitem(Employees; "Incident Line")
            {
                DataItemLinkReference = "Form Header";
                DataItemLink = "Document No." = FIELD("No.");
                column(Employee_No_Employees; Employees."Employee No.") { }
                column(Name_Employees; Employees.Name) { }
                column(Employee_Type_Employees; Employees."Employee Type") { }
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

            trigger OnAfterGetRecord()
            begin
                PaymentTerm.Reset();
                PaymentTerm.SetRange(Code, "Form Header"."Payment Terms");
                if PaymentTerm.FindFirst() then
                    PaymentTermDescription := PaymentTerm.Description;

                if "Form Header"."Document Type" = "Form Header"."Document Type"::"Internal Hire" then
                    ReportTitle := 'INTERNAL HIRE REQUEST'
                else
                    ReportTitle := 'EXTERNAL HIRE REQUEST';
            end;
        }
    }


    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'InternalHire.rdl';
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
        PaymentTermDescription: Text;
        PaymentTerm: Record "Payment Terms";
        ApproverName: Text;
        ReportTitle: Text;
}