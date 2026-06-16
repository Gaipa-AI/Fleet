report 50001 "Fuel Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FuelRequisition.rdl';

    dataset
    {
        dataitem("NFL Requisition Header"; "ADT Requisition Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST("Store Requisition"),
                                      "No." = FILTER(<> ''));
            RequestFilterFields = "Document Type", "No.", "Request-By No.";
            column(PageConst_________FORMAT_CurrReport_PAGENO_; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(Location_Code; "Location Code") { }
            column(NFL_Requisition_Header__No__; "No.")
            {
            }
            column(NFL_Requisition_Header__Requestor_ID_; "Requestor ID")
            {
            }
            column(NFL_Requisition_Header_Status; Status)
            {
            }
            column(NFL_Requisition_Header__Request_By_No__; "Request-By No.")
            {
            }
            column(NFL_Requisition_Header__Request_By_Name_; "Request-By Name")
            {
            }
            column(NFL_Requisition_Header__Order_Date_; "Order Date")
            {
            }
            column(NFL_Requisition_Header__Expected_Receipt_Date_; "Expected Receipt Date")
            {
            }
            column(Store_RequisitionCaption; Store_RequisitionCaptionLbl)
            {
            }
            column(NOT_FOR_ISSUINGCaption; NOT_FOR_ISSUINGCaptionLbl)
            {
            }
            column(NFL_Requisition_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NFL_Requisition_Header__Requestor_ID_Caption; FIELDCAPTION("Requestor ID"))
            {
            }
            column(NFL_Requisition_Header_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(NFL_Requisition_Header__Request_By_No__Caption; FIELDCAPTION("Request-By No."))
            {
            }
            column(NFL_Requisition_Header__Request_By_Name_Caption; FIELDCAPTION("Request-By Name"))
            {
            }
            column(Request_DateCaption; Request_DateCaptionLbl)
            {
            }
            column(NFL_Requisition_Header__Expected_Receipt_Date_Caption; FIELDCAPTION("Expected Receipt Date"))
            {
            }
            column(NFL_Requisition_Header_Document_Type; "Document Type")
            {
            }
            column(Location_Name; LocationCode)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Address; CompanyInformation.Address)
            {

            }
            column(CompanyInformation_address_2; CompanyInformation."Address 2")
            {

            }
            column(CompanyInformation_Email; CompanyInformation."E-Mail")
            {

            }
            column(CompanyInformation_Phone; CompanyInformation."Phone No.")
            {

            }
            column(CompanyInformation_Home; CompanyInformation."Home Page")
            {

            }
            column(CompanyInformation_Tin; CompanyInformation."VAT Registration No.")
            {

            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {

            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {

            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {

            }
            column(Due_Date; "NFL Requisition Header"."Due Date")
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(External_Reference_No_; "External Reference No.")
            {

            }
            column(Posting_Description; "Posting Description")
            {

            }
            column(PillarName; PillarName)
            {

            }
            column(ProjectName; ProjectName)
            {

            }
            column(Valid_to_Date; "Valid to Date")
            {

            }
            column(Request_By_Name; "Request-By Name")
            {
            }
            column(Received_By; "Received By")
            {
            }
            column(Equipment_No_; "Equipment No.") { }
            column(Equipment_RegNo_; "Equipment RegNo.") { }
            column(Driver_Name; "Driver Name") { }
            column(IssuedByName; IssuedByName)
            {
            }
            column(ApprovedByName; ApprovedByName)
            {
            }
            column(Destination; Destination) { }
            column(Signaturey;"Current Approver"){ }
            dataitem("NFL Requisition Line"; "ADT Requisition Line")
            {
                DataItemLinkReference = "NFL Requisition Header";
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(NFL_Requisition_Line_Type; Type)
                {
                }
                column(NFL_Requisition_Line__No__; "No.")
                {
                }
                column(NFL_Requisition_Line__Location_Code_; "Location Code")
                {
                }
                column(NFL_Requisition_Line_Description; Description)
                {
                }
                column(NFL_Requisition_Line__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(NFL_Requisition_Line__Qty__Requested_; "Qty. Requested")
                {
                }
                column(NFL_Requisition_Line__Unit_Cost_; "Unit Cost")
                {
                }
                column(NFL_Requisition_Line__Total_Cost_; "Total Cost")
                {
                }
                column(NFL_Requisition_Line__Inventory_Charge_A_c_; "Inventory Charge A/c")
                {
                }
                column(NFL_Requisition_Line__Qty__Requested__Control1102754038; "Qty. Requested")
                {
                }
                column(NFL_Requisition_Line__Total_Cost__Control1102754039; "Total Cost")
                {
                }
                column(NFL_Requisition_Line_TypeCaption; FIELDCAPTION(Type))
                {
                }
                column(NFL_Requisition_Line__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(NFL_Requisition_Line__Location_Code_Caption; FIELDCAPTION("Location Code"))
                {
                }
                column(NFL_Requisition_Line_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(NFL_Requisition_Line__Unit_of_Measure_Caption; FIELDCAPTION("Unit of Measure"))
                {
                }
                column(QtyCaption; QtyCaptionLbl)
                {
                }
                column(NFL_Requisition_Line__Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
                {
                }
                column(NFL_Requisition_Line__Total_Cost_Caption; FIELDCAPTION("Total Cost"))
                {
                }
                column(NFL_Requisition_Line__Inventory_Charge_A_c_Caption; FIELDCAPTION("Inventory Charge A/c"))
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(NFL_Requisition_Line_Document_Type; "Document Type")
                {
                }
                column(NFL_Requisition_Line_Document_No_; "Document No.")
                {
                }
                column(NFL_Requisition_Line_Line_No_; "Line No.")
                {
                }
                column(Count_Entries; x)
                {
                }
                column(Job_Line_Type; "Job Line Type")
                {
                }
                column(Job_No_; "Job No.")
                {
                }
                column(Job_Task_No_; "Job Task No.")
                {
                }
                column(QuantityIssued; QuantityIssued)
                {

                }
                trigger OnAfterGetRecord();
                var
                    ApprovalEntries: Record "Approval Entry";
                    User: Record User;
                begin
                    x := x + 1;
                    QuantityIssued := 0;

                    if "NFL Requisition Line"."Transfer to Item Jnl" then
                        QuantityIssued := "NFL Requisition Line"."Qty To Transfer to Item Jnl"
                    else
                        if "NFL Requisition Line"."Transfer to Job Jnl" then
                            QuantityIssued := "NFL Requisition Line"."Qty To Transfer to Job Jnl";
                end;

                trigger OnPreDataItem();
                begin
                    x := 0;
                end;
            }

            dataitem("Approval Entry"; "Approval Entry")
            {
                DataItemLinkReference = "NFL Requisition Header";
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

            trigger OnAfterGetRecord();
            var
                ApprovalEntries: Record "Approval Entry";
                User: Record User;
            begin
                IF "NFL Requisition Header"."Location Code" <> '' THEN BEGIN
                    GvLocation.GET("NFL Requisition Header"."Location Code");
                    LocationCode := GvLocation.Name;
                END;

                DimensionValue.Reset();
                DimensionValue.SetRange(Code, "Shortcut Dimension 1 Code");
                if DimensionValue.FindFirst() then
                    PillarName := DimensionValue.Name;

                DimensionValue.Reset();
                DimensionValue.SetRange(Code, "Shortcut Dimension 2 Code");
                if DimensionValue.FindFirst() then
                    ProjectName := DimensionValue.Name;

                IssuedByName := '';
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Document No.", "NFL Requisition Header"."No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.FindLast() then begin
                    User.Reset();
                    User.SetRange("User Name", ApprovalEntries."Approver ID");
                    if User.FindFirst() then
                        IssuedByName := User."Full Name";
                end;

                ApprovedByName := '';
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Document No.", "NFL Requisition Header"."No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.FindFirst() then begin
                    User.Reset();
                    User.SetRange("User Name", ApprovalEntries."Approver ID");
                    if User.FindFirst() then
                        ApprovedByName := User."Full Name";
                end;
            end;

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("No.");
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PageConst: Label 'Page';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Store_RequisitionCaptionLbl: Label 'Store Requisition';
        NOT_FOR_ISSUINGCaptionLbl: Label 'NOT FOR ISSUING';
        Request_DateCaptionLbl: Label 'Request Date';
        QtyCaptionLbl: Label 'Qty';
        TotalCaptionLbl: Label 'Total';
        x: Integer;
        GvLocation: Record Location;
        LocationCode: Text[50];
        CompanyInformation: Record "Company Information";
        PillarName: Text;
        ProjectName: Text;
        DimensionValue: Record "Dimension Value";
        QuantityIssued: Decimal;
        IssuedByName: Text;
        ApprovedByName: Text;
        ApprovalEntries: Record "Approval Entry";
        ApproverName: Text;
}

