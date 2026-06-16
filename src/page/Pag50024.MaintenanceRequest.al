page 50024 "Maintenance Request"
{
    Caption = 'Maintenance Request';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTable = "Maintenance Header";
    DataCaptionFields = "No.", "Equipment No.", "Equipment Name";
    SourceTableView = WHERE("Document Type" = FILTER("Maintenance Request"));

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        FixedAssetRec: Record "Fixed Asset";
                        EquipmentListPage: Page "Equipment Driver List";
                    begin
                        if Rec."Driver No." = '' then begin
                            Message('No driver assigned to this form.');
                            exit;
                        end;
                        FixedAssetRec.SetRange("Responsible Employee", Rec."Driver No.");
                        EquipmentListPage.SetTableView(FixedAssetRec);
                        EquipmentListPage.RunModal();
                    end;
                } 
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                }
                field("Equipment Make"; Rec."Equipment Make")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Make field.', Comment = '%';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field("Equipment Model"; Rec."Equipment Model")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Model field.', Comment = '%';
                }
                field("Equipment Serial No."; Rec."Equipment Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Serial No. field.', Comment = '%';
                }
                field("CheckList No."; Rec."CheckList No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CheckList No. field.', Comment = '%';
                }
                field("Odometer Reading (Km/Hrs)"; Rec."Odometer Reading (Km/Hrs)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Odometer Reading (Km/Hrs) field.', Comment = '%';
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("Requester No."; Rec."Requester No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requester No. field.', Comment = '%';
                }
                field("Requester Name"; Rec."Requester Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requester Name field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                    Editable = false;
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                    Editable = false;
                }
                // field("Approvals Entry"; Rec."Approvals Entry")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Has a Job"; Rec."Has a Job")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the request has an associated job card.';
                    Editable = false;
                }
                field("Job Card No."; Rec."Job Card No.")
                {
                    ApplicationArea = All;
                }
                field("Has Requisition"; Rec."Has Requisition")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Has Requisition field.', Comment = '%';
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                }

                field("Job Closed"; Rec."Job Closed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Closed field.', Comment = '%';
                    Editable = false;
                }

            }
            group("Request Details")
            {
                field("Request Summary"; Rec."Request Summary")
                {
                    ApplicationArea = All;
                    Caption = 'Request Summary';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Request Summary field.', Comment = '%';
                }
                field("Description of Problem"; Rec."Description of Problem")
                {
                    ApplicationArea = All;
                    Caption = 'Description of Problem';
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Description of Problem field.', Comment = '%';
                }
            }
            part("Maintenance Requirements"; "Maintenance Request Subform")
            {
                Caption = 'Maintenance Requirements';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(Factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Maintenance Header"), "No." = FIELD("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Re&quisition")
            {
                Caption = 'Re&quisition';

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Maintenance Request"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }

                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction();
                    begin
                        // Rec.ShowDocDim;
                    end;
                }
                action("Approval Entries")
                {
                    Caption = '&Approval Entries';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = true;
                    ApplicationArea = all;
                    RunObject = Page "NV Approval Entries";
                    RunPageLink = "Document No." = FIELD("No.");
                    RunPageView = WHERE(Status = FILTER(Open | Created | Approved));
                }
                action(DocAttach1)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }

                action("List of All Approval Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&List of All Approval Entries';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = true;
                    RunObject = Page "All NV Approval Entries";
                    RunPageLink = "Document No." = FIELD("No.");
                }
                action(CreateJobCard)
                {
                    ApplicationArea = All;
                    Caption = 'Create Job Card';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = CreateForm;

                    trigger OnAction()
                    begin
                        Rec.TestField("Document Type", Rec."Document Type"::"Maintenance Request");
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField("Equipment No.");
                        Rec.TestField("Equipment Name");
                        Rec.TestField("Driver No.");
                        Rec.TestField("Requester No.");

                        if not Confirm('Are you sure you want to create a Job Card for this Maintenance Request?', true) then
                            exit;
                        CreateJobFromMR();
                        CurrPage.Update(false);
                    end;
                }
                action(CopyRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Request';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Copy;

                    trigger OnAction()
                    begin
                        Rec.TestField("Document Type", Rec."Document Type"::"Maintenance Request");
                        Rec.TestField("Equipment No.");
                        Rec.TestField("Driver No.");
                        Rec.TestField("Requester No.");
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField("Job Closed", true);

                        if not Confirm('Are you sure you want to copy this Maintenance Request?', true) then
                            exit;
                        CopyMaintenanceRequest();
                        CurrPage.Update(false);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        RequisitionHeader: Record "Maintenance Header";
                        MaintenanceReport: Report "Maintenance Request";
                    begin
                        RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Maintenance Request");
                        RequisitionHeader.SETRANGE("No.", Rec."No.");
                        MaintenanceReport.SETTABLEVIEW(RequisitionHeader);
                        MaintenanceReport.RUNMODAL;
                    end;
                }
            }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';
                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                        RequisitionDetailTotal: Decimal;
                        customCodeunit: Codeunit "Fleet Management";
                        MaintenanceLine: Record "Maintenance Line";
                    begin
                        CurrPage.Update();

                        Rec.TESTFIELD("Requester No.");
                        Rec.TESTFIELD("Posting Date");
                        Rec.TESTFIELD("Equipment No.");
                        Rec.TESTFIELD("Equipment Name");
                        Rec.TestField("Driver No.");
                        Rec.TestField("Odometer Reading (Km/Hrs)");
                        Rec.TestField("Request Summary");
                        Rec.TestField("Description of Problem");
                        Rec.TestField("CheckList No.");
                        Rec.TestField(Status, Rec.Status::Open);

                        // Check if there is at least one Maintenance Request Lines
                        MaintenanceLine.Reset();
                        MaintenanceLine.SetRange("Document No.", Rec."No.");
                        if not MaintenanceLine.FindFirst() then
                            ERROR(Text0022);

                        IF Rec."Prepared by" <> USERID THEN
                            ERROR('The selected request can only be sent for approval by the initiator %1', Rec."Prepared by");

                        IF Rec."Request Summary" = '' THEN
                            ERROR('Please specify the Request Summary   for the Maintenance Request');

                        IF Rec."Description of Problem" = '' THEN
                            ERROR('Please specify the Description of Problem for the Maintenance Request');

                        if Confirm('Are you sure you want to send this Approval Request ?', true) then begin
                            if ApprovalsMgmtCut.CheckClaimApprovalsWorkflowEnableMR(Rec) then begin
                                ApprovalsMgmtCut.OnSendClaimForApprovalMR(Rec);
                                customCodeunit.modifyApprovalEntryMR(Rec);
                            end;
                            Rec.SendRequisitionApprovedEmail(Rec);
                            CurrPage.Update();
                        end;
                    end;
                }

                action(ApprovalComments)
                {
                    ApplicationArea = All;
                    Caption = 'Approval Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'Add a comment about the approval request';
                    RunObject = page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = filter("Maintenance Request"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = ViewCancel;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Cancel the approval request.';
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                        RequisitionHeader: Record "Maintenance Header";
                        UserSetup: Record "User Setup";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        CurrPage.Update();
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        IF Rec."Prepared by" <> USERID THEN BEGIN
                            UserSetup.SETRANGE(UserSetup."User ID", USERID);
                            IF UserSetup.FIND('-') THEN BEGIN
                                IF UserSetup."Voucher Admin" = FALSE THEN
                                    ERROR('The voucher can only be cancelled by the initiator %1', Rec."Prepared by");
                            END;
                        END;
                        if Confirm('Are you sure you want to cancel this request ?', true) then begin
                            ApprovalEntry.Reset();
                            ApprovalEntry.SetRange(ApprovalEntry."Document No.", Rec."No.");
                            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                            if ApprovalEntry.FindFirst() then begin
                                customFunction.CancelPurchaseApprovalRequestMR(Rec);
                                //send Email implemented
                                Rec.SendingCancelApprovalEmail(Rec);
                            end else begin
                                customFunction.CancelPurchaseApprovalRequestMR(Rec);
                                //send Email implemented
                                Rec.SendingCancelApprovalEmail(Rec);
                            end;
                            CurrPage.Update();
                        end;
                    end;
                }

                action(ReOpen)
                {
                    ApplicationArea = All;
                    Caption = 'ReOpen';
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ToolTip = 'Reopens the Requisition Document';
                    Image = ReOpen;
                    trigger OnAction()
                    var
                        RequisitionHeader: Record "Maintenance Header";
                    begin
                        CurrPage.Update();
                        if Confirm('Are You Want to Open This Document ?', true) then begin
                            RequisitionHeader.PerformManualReopen(Rec);
                            //send email implemented
                            customFunction.ReopenApprovalEntriesMR(Rec);
                        end;
                    end;
                }
            }

            group(ApprovalApprove)
            {
                Caption = 'Approve';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ClaimCount: Integer;
                        Txt001: Label 'Are you sure you want to Approve this document ?';
                        Txt002: Label 'Please make Sure you have at least one line in the Requisition Lines';
                        UserSetup: Record "User Setup";
                        ApprovalDoc: Codeunit "Fleet Management";
                    begin
                        CurrPage.Update();

                        Rec.TESTFIELD("Requester No.");
                        Rec.TESTFIELD("Posting Date");
                        Rec.TESTFIELD("Equipment No.");
                        Rec.TESTFIELD("Equipment Name");
                        Rec.TestField("Driver No.");
                        Rec.TestField("Odometer Reading (Km/Hrs)");
                        Rec.TestField("Request Summary");
                        Rec.TestField("Description of Problem");

                        if Rec.Status = Rec.Status::Released then
                            Error('This document is already released');
                        if Rec.Status = Rec.Status::Open then
                            Error('Document Status must be set to Pending Approval');

                        ClaimCount := 0;
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange(ApprovalEntry."Document No.", Rec."No.");
                        ApprovalEntry.SetRange(ApprovalEntry."Approval Type", ApprovalEntry."Approval Type"::Approver);
                        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                        if ApprovalEntry.FindFirst() then begin
                            ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        end
                        else begin
                            ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                            Rec.ReleaseTheApprovedDoc();
                        end;
                        //Send email implemented
                        customFunction.OpenApprovalEntriesMR(Rec);
                        Rec.CheckDocumentRelease(Rec);
                        Rec.SendRequisitionApprovedEmail(Rec);
                        // end;

                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    var
                        RequisitionHeader: Record "Maintenance Header";
                        ApprovalComments: Record "Sales Comment Line";
                        ApprovalComments2: Record "Sales Comment Line";
                        approvalComment: Page "Sales Comment Sheet";
                    begin
                        CurrPage.Update();
                        if Confirm('Are you sure you want to Reject this Requisition ?', true) then begin
                            //Checking for comments before rejecting
                            ApprovalComments.Reset();
                            ApprovalComments.SetRange(ApprovalComments."No.", Rec."No.");
                            ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Maintenance Request");
                            Rec.Status := Rec.Status::Rejected;
                            if ApprovalComments.FindFirst() then begin
                                ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                                
                                customFunction.RejectApprovalRequestMR(Rec);
                                Rec.SendRejectEmail(Rec);
                            end else begin
                                ApprovalComments2.Reset();
                                ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"Maintenance Request");
                                ApprovalComments2.SetRange(ApprovalComments2."No.", Rec."No.");
                                ApprovalComments2.SetRange("Document Line No.", 0);
                                approvalComment.SetTableView(ApprovalComments2);
                                approvalComment.Run();
                            end;
                        end;
                    end;
                }

                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = StatusPending;
                    trigger OnAction()
                    var
                        Txt002: Label 'Are you sure you want to Delegate this document ?';
                        CustomPurchFunction: Codeunit "Fleet Management";
                    begin
                        Rec.TESTFIELD("Requester No.");
                        Rec.TESTFIELD("Posting Date");
                        Rec.TESTFIELD("Equipment No.");
                        Rec.TESTFIELD("Equipment Name");
                        Rec.TestField("Driver No.");
                        Rec.TestField("Odometer Reading (Km/Hrs)");
                        Rec.TestField("Request Summary");
                        Rec.TestField("Description of Problem");

                        if Confirm(Txt002, true) then begin
                            CustomPurchFunction.DelegatePurchaseApprovalRequestMR(Rec);
                            Rec.SendRequisitionApprovedEmail(Rec);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    trigger OnOpenPage();
    var
        UserSetup: Record "User Setup";
    begin
        Rec."Document Type" := Rec."Document Type"::"Maintenance Request";
        Rec."Prepared by" := UserId;

        StatusPending := false;
        ViewCancel := false;
        if Rec.Status = Rec.Status::Open then begin
            sendApprovalRequest := true;
        end else begin
            sendApprovalRequest := false;
        end;

        if Rec.Status = Rec.Status::Released then begin
            CancelApprovalVisible := false;
        end else begin
            CancelApprovalVisible := true;
        end;

        if Rec.Status = Rec.Status::"Pending Approval" then begin
            UserSetup.Reset();
            UserSetup.SetRange(UserSetup."User ID", UserId);
            if UserSetup.FindFirst() then begin
                if (UserSetup."Voucher Admin" = true) or (UserId = Rec."Prepared by") then begin
                    StatusPending := true;
                    ViewCancel := true;
                end;
            end;
        end;
    end;


    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ViewCancel: Boolean;
        ApprovalsMgmtCut: Codeunit "Fleet Management";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        gvHeaderTotal: Decimal;
        CanCancelApprovalForFlow: Boolean;
        CanRequestApprovalForFlow: Boolean;
        sendApprovalRequest: Boolean;
        Text0022: Label 'There must be at least one Maintenance Request Line for this Maintenance Request';
        CancelApprovalVisible: Boolean;
        StatusPending: Boolean;
        customFunction: Codeunit "Fleet Management";

    local procedure CreateJobFromMR()
    var
        FleetManagementSetup: Record "Fleet Management Setup";
        NextNo: Code[20];
        MaintenanceJobHeader: Record "Maintenance Header";
        MaintenanceJobHeader1: Record "Maintenance Header";
        MaintenanceLines: Record "Maintenance Line";
        MaintenanceLines1: Record "Maintenance Line";
        ADTRequisitionLine: Record "ADT Requisition Line";
        ADTRequisitionHeader: Record "ADT Requisition Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LineNo: Integer;
        Message: Text;
        JobCard: Page "Maintenance Job Card";
    begin
        LineNo := 1000;
        Rec.TestField(Status, Rec.Status::Released);
        Rec.CalcFields("Job Closed");
        Rec.TestField("Job Closed", false);
        Rec.CalcFields("Has a Job");
        // Rec.TestField("Has a Job", false);
        FleetManagementSetup.Get();

        MaintenanceJobHeader.Init();
        NextNo := NoSeriesMgt.GetNextNo(FleetManagementSetup."Job Card No.", Today, true);
        MaintenanceJobHeader."No." := NextNo;
        MaintenanceJobHeader."Document Type" := MaintenanceJobHeader."Document Type"::"Job Card";
        MaintenanceJobHeader."Posting Date" := Today;
        MaintenanceJobHeader."CheckList No." := Rec."CheckList No.";
        MaintenanceJobHeader."Prepared by" := Rec."Prepared by";
        MaintenanceJobHeader.Insert();
        MaintenanceJobHeader.Validate("Maintenance Request No.", Rec."No.");
        MaintenanceJobHeader.Validate("Odometer Reading (Km/Hrs)", Rec."Odometer Reading (Km/Hrs)");
        MaintenanceJobHeader.Modify();

        //Create the Lines
        MaintenanceLines.Reset();
        MaintenanceLines.SetRange("Document No.", Rec."No.");
        if MaintenanceLines.FindFirst() then begin
            repeat
                MaintenanceLines1.Init();
                MaintenanceLines1."Document Type" := MaintenanceLines1."Document Type"::"Job Card";
                MaintenanceLines1."Line No." := LineNo;
                MaintenanceLines1."Document No." := NextNo;
                MaintenanceLines1.validate(Type, MaintenanceLines.Type);
                MaintenanceLines1.Validate("No.", MaintenanceLines."No.");
                MaintenanceLines1.Description := MaintenanceLines.Description;
                MaintenanceLines1."Description 2" := MaintenanceLines."Description 2";
                MaintenanceLines1.Comment := MaintenanceLines.Comment;
                MaintenanceLines1.Validate("Unit of Measure Code", MaintenanceLines."Unit of Measure Code");
                MaintenanceLines1.Validate(Quantity, MaintenanceLines.Quantity);
                MaintenanceLines1.Insert();
                LineNo := LineNo + 1;
            until MaintenanceLines.Next() = 0;
        end;
        Message := 'Job Card ' + NextNo + ' has been created successfully, would you like to open it?';
        if Confirm(Message, true) then begin
            MaintenanceJobHeader1.SetRange("Document Type", MaintenanceJobHeader1."Document Type"::"Job Card");
            MaintenanceJobHeader1.SetRange("No.", NextNo);
            Page.Run(Page::"Maintenance Job Card", MaintenanceJobHeader1);
        end;
    end;

    local procedure CopyMaintenanceRequest()
    var
        MaintenanceHeader: Record "Maintenance Header";
        MaintenanceLine: Record "Maintenance Line";
        MaintenanceLine1: Record "Maintenance Line";
        NextNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FleetManagementSetup: Record "Fleet Management Setup";
    begin
        FleetManagementSetup.Get();
        MaintenanceHeader.Init();
        NextNo := NoSeriesMgt.GetNextNo(FleetManagementSetup."Maintenance Request No.", Today, true);
        MaintenanceHeader."No." := NextNo;
        MaintenanceHeader."Document Type" := MaintenanceHeader."Document Type"::"Maintenance Request";
        MaintenanceHeader."Posting Date" := Today;
        MaintenanceHeader.Insert();
        MaintenanceHeader.Validate("Equipment No.", Rec."Equipment No.");
        MaintenanceHeader.Validate("Requester No.", Rec."Requester No.");
        MaintenanceHeader.Validate("Driver No.", Rec."Driver No.");
        MaintenanceHeader."No. Series" := FleetManagementSetup."Maintenance Request No.";
        MaintenanceHeader."Posting No. Series" := FleetManagementSetup."Maintenance Request No.";
        MaintenanceHeader."Prepared by" := UserId;

        MaintenanceHeader.Modify();

        MaintenanceLine.Reset();
        MaintenanceLine.SetRange("Document Type", MaintenanceLine."Document Type"::"Maintenance Request");
        MaintenanceLine.SetRange("Document No.", Rec."No.");
        if MaintenanceLine.FindSet() then
            repeat
                MaintenanceLine1.Init();
                MaintenanceLine1."Document Type" := MaintenanceLine."Document Type"::"Maintenance Request";
                MaintenanceLine1."Document No." := NextNo;
                MaintenanceLine1."Line No." := MaintenanceLine."Line No.";
                MaintenanceLine1.Type := MaintenanceLine.Type;
                MaintenanceLine1."No." := MaintenanceLine."No.";
                MaintenanceLine1.Description := MaintenanceLine.Description;
                MaintenanceLine1."Description 2" := MaintenanceLine."Description 2";
                MaintenanceLine1.Comment := MaintenanceLine.Comment;
                MaintenanceLine1.Quantity := MaintenanceLine.Quantity;
                MaintenanceLine1."Unit of Measure" := MaintenanceLine."Unit of Measure";
                MaintenanceLine1."Unit Cost" := MaintenanceLine."Unit Cost";
                MaintenanceLine1.Amount := MaintenanceLine.Amount;
                MaintenanceLine1.Insert();
            until MaintenanceLine.Next() = 0;
        Message('Maintenance Request %1 has been created successfully.', NextNo);
    end;

}