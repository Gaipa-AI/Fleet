page 50063 "Journey Management Plan"
{
    Caption = 'Journey Management Plan';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = filter("Journey Management Plan"));
   // var IsEditable:Boolean;
    

    layout
    {
        
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'JMP Number';
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Site Name"; Rec."Site Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Site Name field.', Comment = '%';
                    Editable = IsEditable;
                }
                field("Validity Date"; Rec."Validity Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Validity Daily field.', Comment = '%';
                }
                field(Validity; Rec.Validity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Validity field.', Comment = '%';
                }
                field("JMP Requester No."; Rec."JMP Requester No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the JMP Requester No. field.', Comment = '%';
                }
                field("JMP Requester Name"; Rec."JMP Requester Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the JMP Requester Name field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field("JMP User No."; Rec."JMP User No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the JMP User No. field.', Comment = '%';
                    Editable = IsEditable;
                }
                field("JMP User Name"; Rec."JMP User Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the JMP User Name field.', Comment = '%';
                }
                

                group("WEEKLY/MONTHLY")
                {
                    field("From Date"; Rec."From Date")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the From Date field.', Comment = '%';
                        Editable = IsEditable;
                    }
                    field("To Date"; Rec."To Date")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the To Date field.', Comment = '%';
                        trigger OnValidate()
                        var
                            DateDiff: Integer;
                        begin
                            if Rec."To Date" >= Rec."From Date" then begin
                                DateDiff := Rec."To Date" - Rec."From Date";
                                Rec.Days := DateDiff + 1;
                            end else
                                Error('To Date must be greater than or equal to From Date');
                        end;
                    }
                    field("Days"; Rec."Days")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Days field.', Comment = '%';
                        Editable = IsEditable;
                               
                    }
                    field("Hours worked"; Rec."Hours")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Hours worked according to JMP.', Comment = '%';
                        Editable = IsEditable;
                    }
                }

                // field("Approvals Entry"; Rec."Approvals Entry")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Approvals Entry field.', Comment = '%';
                // }
                field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Approver field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            group(Itinerary)
            {

                field("Point Of Departure"; Rec."Point Of Departure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Point Of Departure field.', Comment = '%';
                }
                field("Departure Time"; Rec."Departure Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Departure Time field.', Comment = '%';
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination field.', Comment = '%';
                }
                field("Planned Date of Return"; Rec."Planned Date of Return")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Date of Return field.', Comment = '%';
                }
                field(Distance; Rec.Distance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Distance field in KM', Comment = '%';
                    Editable = IsEditable;
                }
                field("Black Top Road"; Rec."Black Top Road")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Black Top Road field.', Comment = '%';
                }
                field("Murram Road"; Rec."Murram Road")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Murram Road field.', Comment = '%';
                }
                field("Stop Over"; Rec."Stop Over")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stop Over field.', Comment = '%';
                }
                field("Personnel Transport"; Rec."Personnel Transport")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Personnel Transport field.', Comment = '%';
                }
                field("Material Transport"; Rec."Material Transport")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Material Transport field.', Comment = '%';
                }
                field("Food Delivery"; Rec."Food Delivery")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Food Delivery field.', Comment = '%';
                }
                field(Other; Rec.Other)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other field.', Comment = '%';
                }
            }
            group(DriverPassengersVehicle)
            {
                Caption = 'Driver-Passengers-Vehicle';
                
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                    //Mandatory = true;
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                    Editable = IsEditable;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("Driver's Contact"; Rec."Driver's Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver''s Contact field.', Comment = '%';
                }
                field("License Expiry Date"; Rec."License Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Valid Drivers License (exp. Date) field.', Comment = '%';
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                    //Caption = 'Vehicle No.';
                    Editable = IsEditable;
                    trigger OnValidate()
                    begin
                        if Rec."Equipment No." <> '' then
                            UpdateLastVehicleInspection();
                    end;
                    trigger OnDrillDown()
                    var
                        FixedAssetRec: Record "Fixed Asset";
                        EquipmentListPage: Page "Equipment Driver List";
                    begin
                        if Rec."Driver No." = '' then begin
                            Message('No driver assigned to this form.');
                            exit;
                        end;
                        FixedAssetRec.SetRange("Responsible Employee", Rec."Former Driver");
                        EquipmentListPage.SetTableView(FixedAssetRec);
                        EquipmentListPage.RunModal();
                    end;
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                    Caption = 'Vehicle RegNo.';
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                    Caption = 'Vehicle Name';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                    Caption = 'Vehicle Type';
                    Editable = false;
                }
                field("Last Vehicle Inspection"; Rec."Last Vehicle Inspection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Vehicle Inspection field.', Comment = '%';
                }
                field("Number Of Passengers"; Rec."Number Of Passengers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number Of Passengers (incl. Driver) field.', Comment = '%';
                }
                field("Number Of Ugandan Citizens"; Rec."Number Of Ugandan Citizens")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number Of Ugandan Citizens field.', Comment = '%';
                }
                field("Number of Resident Foreigners"; Rec."Number of Resident Foreigners")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Resident Foreigners field.', Comment = '%';
                }
                field("NumberOf NonResidentForeigners"; Rec."NumberOf NonResidentForeigners")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number Of Non-Resident Foreigners field.', Comment = '%';
                }
            }
            group(RiskAssessment)
            {
                Caption = 'Risk Assessment';
                field("Risk Assessment"; Rec."Risk Assessment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Risk Assessment field.', Comment = '%';
                }
                field("HSE Induction"; Rec."HSE Induction")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HSE Induction field.', Comment = '%';
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Risk Level field.', Comment = '%';
                }
            }
        }

        area(Factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Form Header"), "No." = FIELD("No.");
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
            group(EquipmentHandOver)
            {
                Caption = 'Journey Management';

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Journey Management Plan"),
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
                        RequisitionHeader: Record "Form Header";
                        MaintenanceReport: Report "Journey Management Plan";
                    begin
                        RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Journey Management Plan");
                        RequisitionHeader.SETRANGE("No.", Rec."No.");
                        MaintenanceReport.SETTABLEVIEW(RequisitionHeader);
                        MaintenanceReport.RUNMODAL;
                    end;
                }
                action(StartJourney)
                {
                    ApplicationArea = All;
                    Caption = 'Start Journey';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = SuggestChartOfAccounts;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField("Driver No.");
                        if Confirm('Are you sure you want to start', true) then
                            Rec.StartJourney();
                    end;
                }
                action(EndJourney)
                {
                    ApplicationArea = All;
                    Caption = 'End Journey';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = SuggestChartOfAccounts;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField("Distance");
                        Rec.TestField("Hours");
                       
                        if Confirm('Are you sure you want to End Journey?', true) then
                            Rec.EndJourney();
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
                        FormLine: Record "Form Line";
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("JMP User No.");
                        Rec.TestField("From Date");

                        IF Rec."Prepared by" <> USERID THEN
                            ERROR('The selected request can only be sent for approval by the initiator %1', Rec."Prepared by");

                        if Confirm('Are you sure you want to send this Approval Request ?', true) then begin
                            if ApprovalsMgmtCut.CheckClaimApprovalsWorkflowEnableFM(Rec) then begin
                                ApprovalsMgmtCut.OnSendClaimForApprovalFM(Rec);
                                customCodeunit.modifyApprovalEntryFM(Rec);
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
                    RunPageLink = "Document Type" = filter("Equipment Hand Over"),
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
                        RequisitionHeader: Record "Form Header";
                        UserSetup: Record "User Setup";
                        ApprovalEntry: Record "Approval Entry";
                    begin
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
                                customFunction.CancelPurchaseApprovalRequestFM(Rec);
                                //send Email implemented
                                Rec.SendingCancelApprovalEmail(Rec);
                            end else begin
                                customFunction.CancelPurchaseApprovalRequestFM(Rec);
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
                        RequisitionHeader: Record "Form Header";
                    begin
                        //Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        if Confirm('Are You Want to Open This Document ?', true) then begin
                            RequisitionHeader.PerformManualReopen(Rec);
                            //send email implemented
                            customFunction.ReopenApprovalEntriesFM(Rec);
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
                        if Rec.Status = Rec.Status::Released then
                            Error('This document is already released');
                        if Rec.Status = Rec.Status::Open then
                            Error('Document Status must be set to Pending Approval');

                        ClaimCount := 0;
                        ApprovalEntry.Reset();
                        //ApprovalEntry."Document No." := Rec."No.";
                        ApprovalEntry.SetRange(ApprovalEntry."Document No.", Rec."No.");
                        ApprovalEntry.SetRange(ApprovalEntry."Approval Type", ApprovalEntry."Approval Type"::Approver);
                        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                        if ApprovalEntry.FindFirst() then begin
                           // ApprovalEntry."Approver ID" := Rec."Current Approver";
                            ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                             
                        end
                        else begin
                            ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                            Rec.ReleaseTheApprovedDoc();
                        end;
                        //Send email implemented
                        customFunction.OpenApprovalEntriesFM(Rec);
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
                        RequisitionHeader: Record "Form Header";
                        ApprovalComments: Record "Sales Comment Line";
                        ApprovalComments2: Record "Sales Comment Line";
                        approvalComment: Page "Sales Comment Sheet";
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        if Confirm('Are you sure you want to Reject this Plan ?', true) then begin
                            
                            //Checking for comments before rejecting
                            ApprovalComments.Reset();
                            ApprovalComments.SetRange(ApprovalComments."No.", Rec."No.");
                            ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Journey Management Plan");
                            if ApprovalComments.FindFirst() then begin
                                ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                                Rec.Status := Rec.Status::Rejected;
                                customFunction.RejectApprovalRequestFM(Rec);
                                Rec.SendRejectEmail(Rec);
                            end else begin
                                ApprovalComments2.Reset();
                                ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"Journey Management Plan");
                                ApprovalComments2.SetRange(ApprovalComments2."No.", Rec."No.");
                                ApprovalComments2.SetRange("Document Line No.", 0);
                                approvalComment.SetTableView(ApprovalComments2);
                                approvalComment.Run();
                            end;
                            Rec.Status := Rec.Status::Rejected;
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

                        Rec.TESTFIELD("Equipment No.");
                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        if Confirm(Txt002, true) then begin
                            CustomPurchFunction.DelegatePurchaseApprovalRequestFM(Rec);
                            Rec.SendRequisitionApprovedEmail(Rec);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var FormHeader: Record "Form Header";
    
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

        if Rec."Journey Started"= false then IsEditable := true 
        else if Rec."Journey Started" = true and Rec."Journey Ended" = false then IsEditable := true
        else IsEditable:=false;         
        
        //IsEditable := not Rec."Journey Ended";
        
    end;

    trigger OnOpenPage();
    var
        UserSetup: Record "User Setup";
    begin
        PreviewMode := true;
        Rec."Document Type" := Rec."Document Type"::"Journey Management Plan";
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

        if Rec.Status in [Rec.Status::"Pending Approval", Rec.Status::Released] then
            PreviewMode := false;
    end;

    local procedure UpdateLastVehicleInspection()
    var
        PrevChecklist: Record "Form Header";
        LastInspectionDate: Date;
    begin
        if Rec."Equipment No." = '' then
            exit;

        PrevChecklist.Reset();
        PrevChecklist.SetRange("Document Type", PrevChecklist."Document Type"::"Journey Management Plan");
        PrevChecklist.SetRange("Equipment No.", Rec."Equipment No.");
        if Rec."No." <> '' then
            PrevChecklist.SetFilter("No.", '<>%1', Rec."No.");

        LastInspectionDate := 0D;
        if PrevChecklist.FindSet() then
            repeat
                if PrevChecklist."Week Start Date" > LastInspectionDate then
                    LastInspectionDate := PrevChecklist."Week Start Date";
            until PrevChecklist.Next() = 0;

        Rec."Last Vehicle Inspection" := LastInspectionDate;
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
        Text0022: Label 'There must be at least one Form Line for this handOver Request';
        CancelApprovalVisible: Boolean;
        StatusPending: Boolean;
        customFunction: Codeunit "Fleet Management";
        PreviewMode: Boolean;
        IsEditable: Boolean;
}