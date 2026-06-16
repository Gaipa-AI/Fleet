table 50012 "Cash Purchase"
{
    Caption = 'Cash Purchase';
    DataClassification = ToBeClassified;
    //*
    LookupPageId = "Cash Purchase List";

    fields
    {
        field(1;"No.";Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()begin
                if "No." <> xRec."No." then begin
                    InventorySetup.Get;
                    NoSeriesMgt.TestManual(InventorySetup."Cash Purchase Nos");
                    "No. Series":='';
                end;
            end;
        }
        field(2;"Document Date";Date)
        {
            Caption = 'Document Date';
            Editable = false;
        }
        field(3;"Document Time";Time)
        {
            Caption = 'Document Time';
            Editable = false;
        }
        field(4;"No. Series";Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5;"User ID";Code[50])
        {
            Caption = 'User ID';
            Editable = false;
        }
        field(6;Status;Enum "Document Status")
        {
            Caption = 'Status';
            Editable = true;
        }
        field(11;"Shortcut Dimension 1 Code";Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=filter(1));
            Editable = false;
        }
        field(12;"Shortcut Dimension 2 Code";Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=filter(2));
        }
        field(13;"Request Date";Date)
        {
            Caption = 'Request Date';
        }
        field(14;"Location Code";Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;

            // trigger OnValidate()begin
            //     UserSetup.Get(UserId);
            //     if not UserSetup.CheckUserLocation("Location Code")then Error('User does not have permission to use this location code!');
            // end;
        }
        field(15;"Inventory Posting Group Filter";Code[200])
        {
            trigger OnLookup()var InvvPostGrou: Record "Inventory Posting Group";
            begin
                InvvPostGrou.Reset;
                if Page.RunModal(112, InvvPostGrou) = Action::LookupOK then;
                "Inventory Posting Group Filter":=InvvPostGrou.Code;
            end;
        }
        field(16;"Transfer To Location";Code[20])
        {
            Caption = 'Transfer To Location';
        }
        field(17;"Expected Requisition Date";Date)
        {
            Caption = 'Expected Requisition Date';
        }
        field(18;"Remarks";Text[100])
        {
            Caption = 'Remarks';
        }
        field(19;Posted;Boolean)
        {
            Caption = 'Posted';

            //Editable = false;
            trigger OnValidate()begin
                "Posted By":=UserId;
                "Date Posted":=Today;
                "Time Posted":=Time;
            end;
        }
        field(20;"Posted By";Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }
        field(21;"Date Posted";Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(22;"Time Posted";Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(23;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(3));
        }
        field(24;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(4));
        }
        field(25;"Approvals Entry"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Approval Entry" where("Document No." = field("No."), Status = filter(open | Created)));

        }
        field(26; "Request Type"; Enum "Request Type")
        {

        }
        
    }
    keys
    {
        key(PK;"No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()begin
        InventorySetup.Get;
        if "No." = '' then begin
            InventorySetup.TestField("Cash Purchase Nos");
            NoSeriesMgt.InitSeries(InventorySetup."Cash Purchase Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Document Date":=Today;
        "Document Time":=Time;
        "User ID":=UserId;
        UserSetup.Get(UserId);
        // "Shortcut Dimension 1 Code":=UserSetup.DefaultAreaCode();
        // "Shortcut Dimension 3 Code":=UserSetup."Shortcut Dimension 3 Code";
        // "Inventory Posting Group Filter":=UserSetup."Inventory Posting Group";
    end;
     trigger OnDelete()
var
    UserSetup: Record "User Setup"; // Record to check user permissions
begin
    // Check if the user is an admin
    UserSetup.Get(UserId);
    
    // If the user is an admin, allow deletion if the status is 'Approved'
    if UserSetup."Approval Administrator" then begin
        if Status <> Status::Released then
            Error('Admin users can only delete records with status ''Approved''. Current status is ''%1''.', Status);
    end else begin
        // If the user is not an admin, allow deletion only if the status is 'Open'
        if Status <> Status::Open then
            Error('Only records with status ''Open'' can be deleted by non-admin users. Current status is ''%1''.', Status);
    end;

    // Reset and delete associated cash lines
    CashLines.Reset;
    CashLines.SetRange(CashLines."Document No.", "No.");
    CashLines.DeleteAll(); // Delete all associated cash lines
end;
    procedure AssistEdit(OldCashPurchase: Record "Cash Purchase"): Boolean var CashPurchase: Record "Cash Purchase";
    begin
        CashPurchase:=Rec;
        InventorySetup.Get;
        InventorySetup.TestField("Cash Purchase Nos");
        // if NoSeriesMgt.SelectSeries(InventorySetup."Cons Material Req No", OldCashPurchase."No. Series", "No. Series")then begin
        //     InventorySetup.Get;
        //     InventorySetup.TestField("Cash Purchase Nos");
        //     NoSeriesMgt.SetSeries("No.");
        //     Rec:=CashPurchase;
        //     exit(true);
        // end;
    end;

    procedure ReleaseTheApprovedDoc()
    var
        NvText: Label 'The approval Request has been Approved';
        PurchaseRequisition: Record "ADT Requisition Header";
    begin
        CalcFields("Approvals Entry");
        if "Approvals Entry" = 0 then begin
            if Rec.Status = Rec.Status::"Pending approval" then begin
                PurchaseRequisition.Reset();
                PurchaseRequisition.SetRange("No.", Rec."No.");
                if PurchaseRequisition.FindFirst() then begin
                    PurchaseRequisition.Status := PurchaseRequisition.Status::Released;
                    PurchaseRequisition."Release date" := Today();
                    PurchaseRequisition.Modify();
                end;
            end;
            Message(NvText);
        end;
    end;

    procedure SendEmailToVoucherOwner(RequisitionHeader: Record "Cash Purchase"; ApprovalEntry: Record "Approval Entry")
    var
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
    begin
        if UserSetup.Get(ApprovalEntry."Sender ID") then begin
            if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::Fuel then begin
                EmailSubject := 'Fuel Requisition Approval in Progress ' + DocumentNo;
                EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Fuel Requisition No. ' + ApprovalEntry."Document No." + ' is with ' + ApprovalEntry."Approver ID";
            end
            else if RequisitionHeader."Request Type" = RequisitionHeader."Request Type"::"Spare Parts" then begin
                EmailSubject := 'Spare Parts Requisition Approval in Progress ' + DocumentNo;
                EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Spare Parts Requisition No. ' + ApprovalEntry."Document No." + ' is with ' + ApprovalEntry."Approver ID";
            end
            else begin
                EmailSubject := 'Spare Parts Requisition Approval in Progress ' + DocumentNo;
                EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Requisition No. ' + ApprovalEntry."Document No." + ' is with ' + ApprovalEntry."Approver ID";
            end;

            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := ApprovalEntry."Document No.";
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure SendEmailToVoucherApprover(RequisitionHeader: Record "Cash Purchase"; ApprovalEntry: Record "Approval Entry")
    var
        ApprovalEmailSubject: Text[150];
        EmailBody: Text[1000];
        MSTRecepientsList: List of [Text];
        MSTCCRecepientsList: List of [Text];
        MSTBCCRecepientsList: List of [Text];
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttachmentInStream: InStream;
        FileMgt: Codeunit "File Management";
        EmailObj: Codeunit Email;
        EmailMsg: Codeunit "Email Message";
        RequisitionStatus: Text[50];
        UserSetup: Record "User Setup";
        DocumentNo: Code[20];
        EmailSubject: Text[250];
    begin
        if UserSetup.Get(ApprovalEntry."Approver ID") then begin
            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>' + 'Requisition No. ' + ApprovalEntry."Document No." + ' is on your desk for approval ' + 'https://dynamics365.bcc.co.ug/BC230/?company=Blue%20Crane%20Communications&page=654';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := ApprovalEntry."Document No.";
            EmailSubject := 'Requisition: ' + DocumentNo + ' Requires Your attension';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;


    procedure SendRequisitionApprovedEmail(RequisitionHeader: Record "Cash Purchase")
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", RequisitionHeader."No.");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst() then begin
            SendEmailToVoucherOwner(RequisitionHeader, ApprovalEntry);
            SendEmailToVoucherApprover(RequisitionHeader, ApprovalEntry);
        end;
    end;
    var InventorySetup: Record "Inventory Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    LocRec: Record Location;
    UserSetup: Record "User Setup";
    CashLines: Record "Cash Purchase Line";
}
