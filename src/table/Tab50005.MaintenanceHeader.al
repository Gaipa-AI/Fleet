table 50005 "Maintenance Header"
{
    Caption = 'Maintenance Header';
    DataCaptionFields = "No.", "Equipment No.", "Equipment Name";

    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate();
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    FleetManagementSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "Document Type"; Enum "Maintenance Type")
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Equipment No."; Code[20])
        {
            TableRelation = "Fixed Asset"."No." where("Equipment Status" = filter(Available));
            trigger OnValidate()
            var
                FixedAsset: Record "Fixed Asset";
            begin
                if "Document Type" = "Document Type"::"Job Card" then
                    Rec.TestField("Job Status", Rec."Job Status"::New)
                else if "Document Type" = "Document Type"::"Maintenance Request" then
                    Rec.TestField(Status, Rec.Status::Open);

                if FixedAsset.Get(Rec."Equipment No.") then begin
                    FixedAsset.TestField("Equipment Status", FixedAsset."Equipment Status"::Available);
                    FixedAsset.TestField("Equipment Type", FixedAsset."Equipment Type");
                    FixedAsset.TestField(Model);
                    FixedAsset.TestField(Make);
                    Rec."Equipment Make" := FixedAsset.Make;
                    Rec."Equipment Name" := FixedAsset.Description;
                    Rec."Equipment Serial No." := FixedAsset."Serial No.";
                    Rec."Equipment Model" := FixedAsset."Model";
                    Rec."Equipment RegNo" := FixedAsset."Registration No.";
                    Rec."Equipment Type" := FixedAsset."Equipment Type";
                    Rec.Validate("Driver No.", FixedAsset."Responsible Employee");
                end else begin
                    Rec."Equipment Make" := '';
                    Rec."Equipment Name" := '';
                    Rec."Equipment Serial No." := '';
                    Rec."Equipment Model" := '';
                    Rec."Equipment RegNo" := '';
                    Rec."Equipment Type" := '';
                    Rec.Validate("Driver Name", '');
                end;
                Rec.Modify();
            end;
        }
        field(4; "Equipment Make"; Text[50])
        {
            Editable = true;
        }
        field(5; "Odometer Reading (Km/Hrs)"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Document Type" = "Document Type"::"Job Card" then
                    Rec.TestField("Job Status", Rec."Job Status"::New)
                else if "Document Type" = "Document Type"::"Maintenance Request" then
                    Rec.TestField(Status, Rec.Status::Open);

                if Rec."Odometer Reading (Km/Hrs)" < 0 then
                    Error('Odometer Reading cannot be negative.');
            end;
        }
        field(6; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Document Type" = "Document Type"::"Job Card" then
                    Rec.TestField("Job Status", Rec."Job Status"::New)
                else if "Document Type" = "Document Type"::"Maintenance Request" then
                    Rec.TestField(Status, Rec.Status::Open);
            end;
        }
        field(7; "Driver No."; Code[20])
        {
            TableRelation = Employee."No." where("Employee Type" = filter('DRIVER'));
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if "Document Type" = "Document Type"::"Job Card" then
                    Rec.TestField("Job Status", Rec."Job Status"::New)
                else if "Document Type" = "Document Type"::"Maintenance Request" then
                    Rec.TestField(Status, Rec.Status::Open);

                if Employee.Get(Rec."Driver No.") then
                    Rec."Driver Name" := Employee.FullName()
                else
                    Rec."Driver Name" := '';

                Rec.Modify();
            end;
        }
        field(8; "Driver Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Requester No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if "Document Type" = "Document Type"::"Job Card" then
                    Rec.TestField("Job Status", Rec."Job Status"::New)
                else if "Document Type" = "Document Type"::"Maintenance Request" then
                    Rec.TestField(Status, Rec.Status::Open);

                if Employee.Get(Rec."Requester No.") then
                    Rec."Requester Name" := Employee.FullName()
                else
                    Rec."Requester Name" := '';

                Rec.Modify();
            end;
        }
        field(10; "Requester Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; Status; Enum "Document Status")
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Requester Date"; Date)
        {
            Editable = false;
        }
        field(13; "Request Summary"; Text[1000])
        {
            trigger OnValidate()
            begin
                if "Document Type" = "Document Type"::"Job Card" then
                    Rec.TestField("Job Status", Rec."Job Status"::New)
                else if "Document Type" = "Document Type"::"Maintenance Request" then
                    Rec.TestField(Status, Rec.Status::Open);
            end;
        }
        field(14; "Description of Problem"; Text[1000])
        {
            trigger OnValidate()
            begin
                if "Document Type" = "Document Type"::"Job Card" then
                    Rec.TestField("Job Status", Rec."Job Status"::New)
                else if "Document Type" = "Document Type"::"Maintenance Request" then
                    Rec.TestField(Status, Rec.Status::Open);
            end;
        }
        field(15; "Maintenance Requirements"; Text[1000])
        {
            trigger OnValidate()
            begin
                if "Document Type" = "Document Type"::"Job Card" then
                    Rec.TestField("Job Status", Rec."Job Status"::New)
                else if "Document Type" = "Document Type"::"Maintenance Request" then
                    Rec.TestField(Status, Rec.Status::Open);
            end;
        }
        field(16; "Equipment Serial No."; Text[100])
        {
            Editable = true;
        }
        field(17; "Equipment Name"; Text[150])
        {
            Editable = false;
        }
        field(18; "Maintenance Request No."; Code[20])
        {
            TableRelation = "Maintenance Header"."No." where("Document Type" = filter("Maintenance Request"), "Status" = filter(Released), "Job Closed" = const(false), "Has a Job" = const(false));
            trigger OnValidate()
            var
                MaintenanceHeader: Record "Maintenance Header";
            begin
                if "Document Type" = "Document Type"::"Job Card" then
                    Rec.TestField("Job Status", Rec."Job Status"::New)
                else if "Document Type" = "Document Type"::"Maintenance Request" then
                    Rec.TestField(Status, Rec.Status::Open);

                if MaintenanceHeader.Get(MaintenanceHeader."Document Type"::"Maintenance Request", Rec."Maintenance Request No.") then begin
                    Rec."Maintenance Request Date" := MaintenanceHeader."Posting Date";
                    Rec."Odometer Reading (Km/Hrs)" := MaintenanceHeader."Odometer Reading (Km/Hrs)";

                    if Rec."Equipment No." = '' then
                        Rec.Validate("Equipment No.", MaintenanceHeader."Equipment No.");
                    if Rec."Driver No." = '' then
                        Rec.Validate("Driver No.", MaintenanceHeader."Driver No.");
                    if Rec."Requester No." = '' then
                        Rec.Validate("Requester No.", MaintenanceHeader."Requester No.");

                end
                else
                    Rec."Maintenance Request Date" := 0D;

                Rec.Modify();
            end;
        }
        field(19; "Maintenance Request Date"; Date)
        {
            Editable = false;
        }
        field(20; "Report Summary"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Other Comments"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Mechanic; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get(rec.Mechanic) then
                    Rec."Mechanic Name" := Employee.FullName()
                else
                    Rec."Mechanic Name" := '';
                Rec.Modify();
            end;
        }
        field(23; "Mechanic Name"; Text[100])
        {
            Editable = false;
        }
        field(24; "Mechanic Date"; Date)
        {
            Editable = false;
        }
        field(25; "Signed By Mechanic"; Boolean)
        {
            trigger OnValidate()
            begin
                if rec."Signed By Mechanic" then
                    Rec."Mechanic Date" := Today
                else
                    Rec."Mechanic Date" := 0D;
                Rec.Modify();
            end;
        }
        field(26; "Workshop Manager No."; Code[20])
        {
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get(Rec."Workshop Manager No.") then
                    Rec."Workshop Manager Name" := Employee.FullName()
                else
                    Rec."Workshop Manager Name" := '';
                Rec.Modify();
            end;
        }
        field(27; "Workshop Manager Name"; Text[150])
        {
            Editable = false;
        }
        field(28; "Signed By Workshop Manager"; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec."Signed By Workshop Manager" then
                    Rec."Workshop Manager Date" := Today
                else
                    Rec."Workshop Manager Date" := 0D;
                Rec.Modify();
            end;
        }
        field(29; "Workshop Manager Date"; Date)
        {
            Editable = false;
        }
        field(30; "Signed By Requester"; Boolean)
        {
            trigger OnValidate()
            begin
                if Rec."Signed By Requester" then
                    Rec."Requester Date" := Today
                else
                    Rec."Requester Date" := 0D;
                Rec.Modify();
            end;
        }
        field(31; Remarks; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(33; "Job Status"; Enum "Job Card Status")
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Posting No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(35; "Prepared by"; Code[100])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(36; "Approvals Entry"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Approval Entry" where("Document No." = field("No."), Status = filter(open | Created)));
        }
        field(37; "Current Approver"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field("No.")));
            //, Status = filter(Open)));
        }
        field(38; "Job Start Date"; Date)
        {
            Editable = false;
        }
        field(39; "Job End Date"; Date)
        {
            Editable = false;
        }
        field(40; "Job Cancel Date"; Date)
        {
            Editable = false;
        }
        field(41; "Job Cancelled By"; Code[100])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(42; "Job Ended By"; Code[100])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(43; "Job Start By"; Code[100])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(44; "Job Authorized"; Boolean)
        {
            Editable = false;
        }
        field(45; "Authorized By"; Code[100])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(46; "Authorized Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Total Cost"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Maintenance Line"."Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(49; "Job Closed"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Maintenance Header" where("Document Type" = filter("Job Card"), "Maintenance Request No." = field("No."), "Job Status" = filter(Closed)));
            Editable = false;
        }
        field(50; "Equipment Model"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Equipment RegNo"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
            DataClassification = ToBeClassified;
        }
        field(53; "Has a Job"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Maintenance Header" where("Document Type" = filter("Job Card"), "Maintenance Request No." = field("No.")));
            Editable = false;
        }
        field(54; "Has Requisition"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("ADT Requisition Header" where("Document Type" = filter("Purchase Requisition"), "Maintenance Request No." = field("No."), Status = filter("Pending Approval" | Released)));
        }
        field(55; "Job Card No."; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Maintenance Header"."No." where("Document Type" = filter("Job Card"), "Maintenance Request No." = field("No.")));
            Editable = false;
        }
        field(56; "Requisition No."; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("ADT Requisition Header"."No." where("Document Type" = filter("Purchase Requisition"), "Maintenance Request No." = field("No."), Status = filter("Pending Approval" | Released | Open)));
        }
        field(57; "CheckList No."; Code[20])
        {
            TableRelation = "Form Header"."No." where("Document Type" = filter("Equipment Inspection"), "Equipment No." = field("Equipment No."), "State" = const("Faulty"));
            trigger OnValidate()
            begin
                Rec.TestField("Equipment No.");
            end;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(DropDown; "No.", "Equipment No.", "Equipment Name", "Equipment Serial No.") { }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FleetManagementSetup: Record "Fleet Management Setup";
        ANFSetup: Record "Fleet Management Setup";
        Text003: Label 'You cannot rename a %1.';

    trigger OnInsert()
    begin
        "Posting Date" := Today;
        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;

        InitRecord;
        Rec."Prepared by" := UserId;
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    var
        MaintenanceLines: Record "Maintenance Line";
        DocumentAttachments: Record "Document Attachment";
    begin
        TestField("Status", Rec.Status::Open);
        if "Document Type" = "Document Type"::"Job Card" then
            if "Job Status" in ["Job Status"::Closed, "Job Status"::"In Progress"] then
                Error('You cannot delete a Job Card that is not in New|cancelled status.');

        //Delete all lines related to this header
        MaintenanceLines.Reset();
        MaintenanceLines.SetRange("Document Type", "Document Type");
        MaintenanceLines.SetRange("Document No.", "No.");
        if MaintenanceLines.FindSet() then
            repeat
                MaintenanceLines.Delete();
            until MaintenanceLines.Next() = 0;

        //delete the attachments related to this header
        DocumentAttachments.Reset();
        DocumentAttachments.SetRange("No.", Rec."No.");
        if DocumentAttachments.FindSet() then
            repeat
                DocumentAttachments.Delete();
            until DocumentAttachments.Next() = 0;
    end;

    trigger OnRename();
    begin
        ERROR(Text003, TABLECAPTION);
    end;

    /// <summary>
    /// Description for AssistEdit.
    /// </summary>
    /// <param name="MaintenanceHeader">Parameter of type Record "ADT Requisition Header".</param>
    /// <returns>Return variable "Boolean".</returns>
    procedure AssistEdit(MaintenanceHeader: Record "Maintenance Header"): Boolean;
    begin
        ANFSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, MaintenanceHeader."No. Series", "No. Series") THEN BEGIN
            FleetManagementSetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    /// <summary>
    /// Description for TestNoSeries.
    /// </summary>
    /// <returns>Return variable "Boolean".</returns>
    local procedure TestNoSeries(): Boolean;
    begin
        FleetManagementSetup.GET;
        CASE "Document Type" OF
            "Document Type"::"Maintenance Request":
                FleetManagementSetup.TESTFIELD("Maintenance Request No.");
            "Document Type"::"Job Card":
                FleetManagementSetup.TESTFIELD("Job Card No.");
        END;
    end;

    /// <summary>
    /// Description for GetNoSeriesCode.
    /// </summary>
    /// <returns>Return variable "Code[10]".</returns>
    local procedure GetNoSeriesCode(): Code[10];
    begin

        CASE "Document Type" OF
            "Document Type"::"Maintenance Request":
                exit(FleetManagementSetup."Maintenance Request No.");
            "Document Type"::"Job Card":
                exit(FleetManagementSetup."Job Card No.");
        END;
    end;

    procedure InitRecord();
    begin
        ANFSetup.GET;
        CASE "Document Type" OF
            "Document Type"::"Maintenance Request":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (ANFSetup."Store Requisition Nos" = ANFSetup."Store Requisition Nos")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Store Requisition Nos");
                    "Prepared by" := UserId;
                END;

            "Document Type"::"Job Card":
                BEGIN
                    IF ("No. Series" <> '') AND
                       (ANFSetup."Store Requisition Nos" = ANFSetup."Store Requisition Nos")
                    THEN
                        "Posting No. Series" := "No. Series"
                    ELSE
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", ANFSetup."Store Requisition Nos");
                END;
        END;

        "Posting Date" := Today;

        if "Document Type" = "Document Type"::"Maintenance Request" then
            "Job Status" := "Job Card Status"::New;

        if "Posting Date" = 0D then
            "Posting Date" := Today;
    end;

    //================================Approval=========================================

    procedure PerformManualReopen(VAR NFLRequisitionHeader: Record "Maintenance Header")
    var
        UserSetUp: Record "User Setup";
        VoucherAdmin: Boolean;
    begin
        VoucherAdmin := false;

        UserSetUp.Reset();
        UserSetUp.SetRange(UserSetUp."User ID", UserId);
        UserSetUp.SetRange(UserSetUp."Voucher Admin", true);
        if UserSetUp.FindFirst() then begin
            VoucherAdmin := true;
        end;
        if (VoucherAdmin = true) then begin
            IF NFLRequisitionHeader.Status = NFLRequisitionHeader.Status::"Pending Approval" THEN
                ERROR('You Can not open a document Pending Approval');
            Reopen(NFLRequisitionHeader);
        end else begin
            Error('Your not allowed to perform this Operation, Document can only be opened by Voucher Admin');
        end;
    end;

    procedure Reopen(VAR NFLRequisitionHeader: Record "Maintenance Header")
    begin
        WITH NFLRequisitionHeader DO BEGIN
            IF Status = Status::Open THEN
                EXIT;
            Status := Status::Open;
            MODIFY(TRUE);
            Message('The Document has been Reopened Successfully');
        END;
    end;

    procedure ReleaseTheApprovedDoc()
    var
        NvText: Label 'The approval Request has been Approved';
        MaintenanceRequisition: Record "Maintenance Header";
    begin
        CalcFields("Approvals Entry");
        if "Approvals Entry" = 0 then begin
            if Rec.Status = Rec.Status::"Pending approval" then begin
                MaintenanceRequisition.Reset();
                MaintenanceRequisition.SetRange("No.", Rec."No.");
                if MaintenanceRequisition.FindFirst() then begin
                    MaintenanceRequisition.Status := MaintenanceRequisition.Status::Released;
                    MaintenanceRequisition.Modify();
                end;
            end;
            Message(NvText);
        end;
    end;

    //check he document release
    procedure CheckDocumentRelease(var MaintenanceRequisition: Record "Maintenance Header")
    var
        ApprovalEntries: Record "Approval Entry";
        NotReleased: Boolean;
        countNumber: Integer;
    begin
        NotReleased := false;
        countNumber := 0;

        ApprovalEntries.Reset();
        ApprovalEntries.SetRange("Document No.", MaintenanceRequisition."No.");
        if ApprovalEntries.FindFirst() then begin
            repeat
                if (ApprovalEntries.Status = ApprovalEntries.Status::Open) or (ApprovalEntries.Status = ApprovalEntries.Status::Created) then
                    NotReleased := true;
                countNumber += 1;
            until ApprovalEntries.Next() = 0;
        end;

        if (countNumber > 0) and (NotReleased = false) then
            Rec.SendReleaseEmail(MaintenanceRequisition);
    end;


    procedure SendingCancelApprovalEmail(RequisitionHeader: Record "Maintenance Header")
    var
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
    begin

    end;

    procedure SendRequisitionApprovedEmail(RequisitionHeader: Record "Maintenance Header")
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

    procedure SendEmailToVoucherOwner(RequisitionHeader: Record "Maintenance Header"; ApprovalEntry: Record "Approval Entry")
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
            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Maintenance Request No. ' + ApprovalEntry."Document No." + ' is with ' + ApprovalEntry."Approver ID";
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := ApprovalEntry."Document No.";
            EmailSubject := 'Maintenance Approval in Progress ' + DocumentNo;
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure SendEmailToVoucherApprover(RequisitionHeader: Record "Maintenance Header"; ApprovalEntry: Record "Approval Entry")
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
            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>' + 'Maintenance Request No. ' + ApprovalEntry."Document No." + ' is on your desk for approval ' + 'https://dynamics365.bcc.co.ug/BC230/?company=Blue%20Crane%20Communications&page=654';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := ApprovalEntry."Document No.";
            EmailSubject := 'Maintenance Request ' + DocumentNo + ' Requires Your attention';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure SendReleaseEmail(RequisitionHeader: Record "Maintenance Header")
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
        if UserSetup.Get(RequisitionHeader."Prepared by") then begin
            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Maintenance Request No. ' + RequisitionHeader."No." + ' has been Approved/Released.';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := RequisitionHeader."No.";
            EmailSubject := 'Maintenance Request ' + DocumentNo + ' has been approved.';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure SendRejectEmail(RequisitionHeader: Record "Maintenance Header")
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
        RejectComment: Text[1000];
        SalesCommentLine: Record "Sales Comment Line";
    begin
        if UserSetup.Get(RequisitionHeader."Prepared by") then begin
            SalesCommentLine.Reset();
            SalesCommentLine.SetRange("No.", RequisitionHeader."No.");
            SalesCommentLine.SetRange("Document Type", SalesCommentLine."Document Type"::"Maintenance Request");
            if SalesCommentLine.FindLast() then
                RejectComment := SalesCommentLine.Comment;

            EmailBody := 'Dear ' + UserSetup."E-Mail" + '<br>Maintenance Request No. ' + RequisitionHeader."No." + ' has been Rejected by ' + UserId + ' because "' + RejectComment + '"';
            MSTRecepientsList.Add(UserSetup."E-Mail");
            DocumentNo := RequisitionHeader."No.";
            EmailSubject := 'Maintenance Request ' + DocumentNo + ' has been Rejected.';
            EmailMsg.Create(MSTRecepientsList, EmailSubject,
            EmailBody,
            true, MSTCCRecepientsList, MSTBCCRecepientsList);
            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure MaintenanceRequisitionDelegate(var MaintenanceRequisition: Record "Maintenance Header")
    var
        Txt002: Label 'Are you sure you want to Delegate this document ?';
        CustomPurchFunction: Codeunit "Fleet Management";
    begin
        if Confirm(Txt002, true) then begin
            CustomPurchFunction.DelegatePurchaseApprovalRequestMR(MaintenanceRequisition);
            MaintenanceRequisition.SendRequisitionApprovedEmail(MaintenanceRequisition);
        end;
    end;

    procedure MaintenanceRequisitionReject(var MaintenanceRequisition: Record "Maintenance Header")
    var
        RequisitionHeader: Record "Maintenance Header";
        ApprovalComments: Record "Sales Comment Line";
        ApprovalComments2: Record "Sales Comment Line";
        approvalComment: Page "Sales Comment Sheet";
        CustomPurchFunction: Codeunit "Fleet Management";
        customFunction: Codeunit "Fleet Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if Confirm('Are you sure you want to Reject this Requisition ?', true) then begin
            //Checking for comments before rejecting
            ApprovalComments.Reset();
            ApprovalComments.SetRange(ApprovalComments."No.", MaintenanceRequisition."No.");
            ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Maintenance Request");
            if ApprovalComments.FindFirst() then begin
                ApprovalsMgmt.RejectRecordApprovalRequest(MaintenanceRequisition.RecordId);
                customFunction.RejectApprovalRequestMR(MaintenanceRequisition);
                MaintenanceRequisition.SendRejectEmail(MaintenanceRequisition);
            end else begin
                ApprovalComments2.Reset();
                ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"Maintenance Request");
                ApprovalComments2.SetRange(ApprovalComments2."No.", MaintenanceRequisition."No.");
                ApprovalComments2.SetRange("Document Line No.", 0);
                approvalComment.SetTableView(ApprovalComments2);
                approvalComment.Run();
            end;
        end;
    end;

    procedure MaintenanceRequisitionApprove(var MaintenanceRequisition: Record "Maintenance Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ClaimCount: Integer;
        Txt001: Label 'Are you sure you want to Approve this document ?';
        Txt002: Label 'Please make Sure you have at least one line in the Requisition Lines';
        UserSetup: Record "User Setup";
        ApprovalDoc: Codeunit "Fleet Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        customFunction: Codeunit "Fleet Management";
    begin
        if MaintenanceRequisition.Status = MaintenanceRequisition.Status::Released then
            Error('This document is already released');
        if MaintenanceRequisition.Status = MaintenanceRequisition.Status::Open then
            Error('Document Status must be set to Pending Approval');

        if Confirm(Txt001, true) then begin
            ClaimCount := 0;
            ApprovalEntry.Reset();
            ApprovalEntry.SetRange(ApprovalEntry."Document No.", MaintenanceRequisition."No.");
            ApprovalEntry.SetRange(ApprovalEntry."Approval Type", ApprovalEntry."Approval Type"::Approver);
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.FindFirst() then begin
                ApprovalsMgmt.ApproveRecordApprovalRequest(MaintenanceRequisition.RecordId);
            end
            else begin
                ApprovalsMgmt.ApproveRecordApprovalRequest(MaintenanceRequisition.RecordId);
                MaintenanceRequisition.ReleaseTheApprovedDoc();
            end;
            //Send email implemented
            customFunction.OpenApprovalEntriesMR(MaintenanceRequisition);
            MaintenanceRequisition.CheckDocumentRelease(MaintenanceRequisition);
            MaintenanceRequisition.SendRequisitionApprovedEmail(MaintenanceRequisition);
        end;
    end;

}