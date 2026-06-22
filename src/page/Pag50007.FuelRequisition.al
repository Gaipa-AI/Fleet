page 50007 "Fuel Requisition"
{
    Caption = 'Consumption';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTable = "ADT Requisition Header";
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER("Store Requisition"), "Request Type" = filter(Fuel));
    Permissions = tabledata "ADT Requisition Header" = rm,
                      tabledata "ADT Requisition Line" = rm,
                      tabledata "Email Related Attachment" = rm;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Visible = true;
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Request-By No."; Rec."Request-By No.")
                {
                    Caption = 'Request-By No.';
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Request-By Name"; Rec."Request-By Name")
                {
                    Caption = 'Request-By Name';
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Fuel Pick Up Location"; Rec."Fuel Pick Up Location")
                {
                    ApplicationArea = All;
                }

                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    Caption = 'Vehicle';
                    ApplicationArea = All;
                }
                field("Equipment RegNo."; Rec."Equipment RegNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle Registration No.';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle Type';
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                // field("Request Type"; Rec."Request Type")
                // {
                //     ApplicationArea = All;
                // }
                field("Posting Description"; Rec."Posting Description")
                {
                    Caption = 'Purpose of Travel';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Caption = 'Request Date';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Current Approver field.', Comment = '%';
                    Caption = 'Approver';
                }
                // field("Received By"; Rec."Received By")
                // {
                //     ApplicationArea = All;
                // }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Archived; Rec.Archived)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requisition Total Cost"; Rec."Requisition Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition Total Cost field.';
                    Editable = false;
                }
                // field("Requisition Lines Total"; Rec."Requisition Lines Total")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Requisition Lines Total field.';
                //     Visible = true;
                // }
                // field("Approvals Entry"; Rec."Approvals Entry")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Approvals Entry field.', Comment = '%';
                // }
                // field("Current Approver"; Rec."Current Approver")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Current Approver field.', Comment = '%';
                // }
                field("User ID"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
            }
            part(PurchLines; "Fuel Requisition Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }

        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"ADT Requisition Header"), "No." = FIELD("No.");
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
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Employee Card";
                    RunPageLink = "No." = FIELD("Request-By No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = CONST(10),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "NFL Approval Entries";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"ADT Requisition Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
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
                separator("...")
                {
                }
                group("Cross Referencing")
                {
                    Caption = 'Cross Referencing';
                    action("Purchase Req.")
                    {
                        Caption = 'Purchase Req.';
                        RunObject = Page "NFL Requisition List";
                        RunPageLink = "Store Requisition No." = FIELD("No.");
                        RunPageView = SORTING("Document Type", "No.")
                                      WHERE("Document Type" = CONST("Purchase Requisition"));
                    }
                    action("Purchase Quote")
                    {
                        Caption = 'Purchase Quote';
                        Image = Quote;
                        RunObject = Page "Purchase List";
                        RunPageView = SORTING("Document Type", "No.")
                                      WHERE("Document Type" = CONST(Quote));
                    }
                    action("Archived Purchase Quote")
                    {
                        Caption = 'Archived Purchase Quote';
                        RunObject = Page "Purchase List Archive";
                        RunPageView = SORTING("Document Type", "No.", "Doc. No. Occurrence", "Version No.")
                                      WHERE("Document Type" = CONST(Quote));
                    }
                    action("Purchase Orders")
                    {
                        Caption = 'Purchase Orders';
                        RunObject = Page "Purchase List";
                        RunPageView = SORTING("Document Type", "No.")
                                      WHERE("Document Type" = CONST(Order));
                    }
                    action("Archived Purchase Orders")
                    {
                        Caption = 'Archived Purchase Orders';
                        RunObject = Page "Purchase List Archive";
                        RunPageView = SORTING("Document Type", "No.", "Doc. No. Occurrence", "Version No.")
                                      WHERE("Document Type" = CONST(Order));
                    }
                    action("Purchase Receipt")
                    {
                        Caption = 'Purchase Receipt';
                        RunObject = Page "Posted Purchase Receipts";
                    }
                    action("Posted Purchase Invoices")
                    {
                        Caption = 'Posted Purchase Invoices';
                        RunObject = Page "Posted Purchase Invoices";
                    }
                }
                action("Revision Log")
                {
                    Caption = 'Revision Log';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Consume from Stock")
                {
                    Caption = 'Consume from Stock';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = TransferToGeneralJournal;
                    trigger OnAction();
                    var
                        BankReconn: Record "Bank Acc. Reconciliation";
                        PaymentJnl: Record "Gen. Journal Line";
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TESTFIELD("No.");
                        Rec.TESTFIELD("Request-By No.");
                        IF CONFIRM('Are you sure you want to transfer these lines to Item journal?') THEN BEGIN
                            if Rec."Request Type" = Rec."Request Type"::Fuel then begin
                                ANFSetup.GET;
                                ANFSetup.TESTFIELD("Fuel Req Item Jnl Template");
                                ANFSetup.TESTFIELD("Fuel Req Item Jnl Batch");
                                TransferToItemJnl(ANFSetup."Fuel Req Item Jnl Template", ANFSetup."Fuel Req Item Jnl Batch");
                                Rec.ArchiveStoreRequisition();
                            end else if Rec."Request Type" = Rec."Request Type"::General then begin
                                ANFSetup.GET;
                                ANFSetup.TESTFIELD("Store Req Item Jnl Template");
                                ANFSetup.TESTFIELD("Store Req Item Jnl Batch");
                                TransferToItemJnl(ANFSetup."Store Req Item Jnl Template", ANFSetup."Store Req Item Jnl Batch");
                                Rec.ArchiveStoreRequisition();
                            end else if Rec."Request Type" = Rec."Request Type"::"Spare Parts" then begin
                                ANFSetup.GET;
                                ANFSetup.TESTFIELD("Spare Req Item Jnl Template");
                                ANFSetup.TESTFIELD("Spare Req Item Jnl Batch");
                                TransferToItemJnl(ANFSetup."Spare Req Item Jnl Template", ANFSetup."Spare Req Item Jnl Batch");
                                Rec.ArchiveStoreRequisition();
                            end
                        END;
                    end;
                }

                action("Archive Fuel Requisition")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Archive;

                    trigger OnAction()
                    begin
                        Rec.ArchiveStoreRequisition();
                    end;
                }

                action("Make Purchase Requisition")
                {
                    Caption = 'Make Purchase Requisition';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    trigger OnAction();
                    var
                        BankReconn: Record "Bank Acc. Reconciliation";
                        PaymentJnl: Record "Gen. Journal Line";
                    begin
                        ANFSetup.GET;
                        ANFSetup.TESTFIELD("Store Req. Archive No. Series");
                        CloseStoreReq;
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        ReqnHeader: Record "ADT Requisition Header";
                        RptStoreReqn: Report "Fuel Requisition";
                    begin
                        ReqnHeader.SETRANGE("Document Type", ReqnHeader."Document Type"::"Store Requisition");
                        ReqnHeader.SETRANGE("No.", Rec."No.");
                        RptStoreReqn.SETTABLEVIEW(ReqnHeader);
                        RptStoreReqn.RUNMODAL;
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
                        StoreReqLines: Record "ADT Requisition Line";
                    begin
                        CurrPage.Update();
                        Rec.CalcFields("Requisition Lines Total");
                        Rec.CalcFields("Total Cost");

                        Rec.TESTFIELD("Request-By No.");
                        Rec.TestField(Status, Rec.Status::Open);

                        IF Rec."Prepared by" <> USERID THEN
                            ERROR('The selected request can only be sent for approval by the initiator %1', Rec."Prepared by");

                        IF Rec."Posting Description" = '' THEN
                            ERROR('Please specify the subject of Procurement');

                        if Rec."Total Cost" <= 0 then
                            Error('Make sure you have lines in your stores requisitions or capture the cost for each Item.');

                        StoreReqLines.Reset();
                        StoreReqLines.SetRange("Document No.", Rec."No.");
                        if StoreReqLines.FindFirst() then begin
                            repeat
                                if (StoreReqLines."Qty. Requested" > 0) and (StoreReqLines."Unit Cost" <= 0) then
                                    Error('Item: %1 does not have a unit cost', StoreReqLines."No.");
                            until StoreReqLines.Next() = 0;
                        end;

                        if Confirm('Are you sure you want to send this Approval Request ?', true) then begin
                            if ApprovalsMgmtCut.CheckClaimApprovalsWorkflowEnablePRQ(Rec) then begin
                                ApprovalsMgmtCut.OnSendClaimForApprovalPRQ(Rec);
                                customCodeunit.modifyApprovalEntryPRQ(Rec);
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
                    RunPageLink = "Document Type" = CONST("Purchase Requisition"),
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
                        RequisitionHeader: Record "ADT Requisition Header";
                        UserSetup: Record "User Setup";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        CurrPage.Update();
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        if Rec."Converted to Order" = TRUE then
                            ERROR('The purchase requisition has already been converted to an order');
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
                                customFunction.CancelPurchaseApprovalRequestPRQ(Rec);
                                //send Email implemented
                                Rec.SendingCancelApprovalEmail(Rec);
                            end else begin
                                customFunction.CancelPurchaseApprovalRequestPRQ(Rec);
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
                        RequisitionHeader: Record "ADT Requisition Header";
                    begin
                        CurrPage.Update();
                        if Confirm('Are You Want to Open This Document ?', true) then begin
                            RequisitionHeader.PerformManualReopen(Rec);
                            //send email implemented
                            customFunction.ReopenApprovalEntriesPRQ(Rec);
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
                        StoreReqLines: record "ADT Requisition Line";
                    begin
                        CurrPage.Update();
                        Rec.CalcFields("Total Cost");
                        if Rec.Status = Rec.Status::Released then
                            Error('This document is already released');
                        if Rec.Status = Rec.Status::Open then
                            Error('Document Status must be set to Pending Approval');

                        if Rec."Total Cost" <= 0 then begin
                            Error(Txt002);
                        end;

                        StoreReqLines.Reset();
                        StoreReqLines.SetRange("Document No.", Rec."No.");
                        if StoreReqLines.FindFirst() then begin
                            repeat
                                if (StoreReqLines."Qty. Requested" > 0) and (StoreReqLines."Unit Cost" <= 0) then
                                    Error('Item: %1 does not have a unit cost', StoreReqLines."No.");
                            until StoreReqLines.Next() = 0;
                        end;

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
                        customFunction.OpenApprovalEntriesPRQ(Rec);
                        Rec.CheckDocumentRelease(Rec);
                        Rec.SendRequisitionApprovedEmail(Rec);
                        // end;

                    end;
                }
                action(Refresh)
                {
                    ApplicationArea = All;
                    Caption = 'Refresh';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Refresh;

                    trigger OnAction()
                    begin
                        CurrPage.Update();
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
                        RequisitionHeader: Record "ADT Requisition Header";
                        ApprovalComments: Record "Sales Comment Line";
                        ApprovalComments2: Record "Sales Comment Line";
                        approvalComment: Page "Sales Comment Sheet";
                    begin
                        CurrPage.Update();
                        if Confirm('Are you sure you want to Reject this Requisition ?', true) then begin
                            //Checking for comments before rejecting
                            ApprovalComments.Reset();
                            ApprovalComments."No." := Rec."No.";
                            ApprovalComments.SetRange(ApprovalComments."No.", Rec."No.");
                            ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Purchase Requisition");
                            if ApprovalComments.FindFirst() then begin
                                ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                                Rec.Status := Rec.Status::Rejected;
                                customFunction.RejectApprovalRequestPRQ(Rec);
                                Rec.SendRejectEmail(Rec);
                            end else begin
                                ApprovalComments2.Reset();
                                ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"Purchase Requisition");
                                ApprovalComments2.SetRange(ApprovalComments2."No.", Rec."No.");
                                ApprovalComments2.SetRange("Document Line No.", 0);
                                approvalComment.SetTableView(ApprovalComments2);
                                approvalComment.Run();
                            end;
                        end;
                    end;
                }

                action(EscalateRequisition)
                {
                    ApplicationArea = All;
                    Caption = 'Escalate';
                    Image = ElectronicRegister;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'Escalate the approval to a Escalate approver.';
                    // Visible = OpenApprovalEntriesExistForCurrUser;
                    Visible = false;
                    trigger OnAction()
                    var
                        Txt002: Label 'Are you sure you want to Escalate this document ?';
                        CustomFunctionApproval: Codeunit "Fleet Management";
                    begin
                        CurrPage.Update();
                        if Confirm(Txt002, true) then begin
                            CustomFunctionApproval.EscalateGeneralRequisition(Rec);
                            Rec.SendRequisitionApprovedEmail(Rec);
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
                        CurrPage.Update();
                        if Confirm(Txt002, true) then begin
                            CustomPurchFunction.DelegatePurchaseApprovalRequestPRQ(Rec);
                            Rec.SendRequisitionApprovedEmail(Rec);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

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
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;

        Rec."Document Type" := Rec."Document Type"::"Store Requisition";
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
        PurchSetup: Record "Purchases & Payables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        // ApprovalMgt: Codeunit "NFL Approvals Management";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        // ArchiveManagement: Codeunit "NFL ArchiveManagement";
        Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2. Do you wish to continue?';
        PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";
        ANFSetup: Record "Fleet Management Setup";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        StoreReqHeader: Record "ADT Requisition Header";
        StoreReqLine: Record "ADT Requisition Line";
        ReserveMgt: Codeunit "Reservation Management";
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
        Text0022: Label 'There must be at least one line with amount in the Purchase requisition Details Subform';
        CancelApprovalVisible: Boolean;
        StatusPending: Boolean;
        customFunction: Codeunit "Fleet Management";


    /// <summary>
    /// Description for TransferToItemJnl.
    /// </summary>
    procedure TransferToItemJnl(JournalTemplate: Code[50]; JournalBatch: Code[50]);
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SourceCodeSetup: Record "Source Code Setup";
        LineNo: Integer;
        PurchPaySetup: Record "Purchases & Payables Setup";
        lvItem: Record Item;
        lvItemsString: Text[250];
        lvBoolDelete: Boolean;
        FromType: Option " ",ItemJnl,PurchaseReq;
        FirstLineNo: Integer;
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        CheckApplFromItemEntry: Boolean;
        InvtQty: Decimal;
        NFLInfoPaneMgt: Codeunit "Fleet Management";
        OneStoreReqLine: Record "ADT Requisition Line";
        ItemJournalLines: Record "Item Journal Line";
        Message: Text;
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJournalPage: Page "Item Journal";
        ItemJnlPost: Codeunit "Item Jnl.-Post";
    begin
        ItemJnlLine.RESET;
        ItemJnlLine.SETFILTER("Journal Template Name", JournalTemplate);
        ItemJnlLine.SETFILTER("Journal Batch Name", JournalBatch);
        IF ItemJnlLine.FINDLAST THEN
            LineNo := ItemJnlLine."Line No."
        ELSE
            LineNo := 0;

        lvBoolDelete := TRUE;
        FirstLineNo := LineNo + 10000;
        StoreReqLine.SETFILTER("Document Type", FORMAT(StoreReqLine."Document Type"::"Store Requisition"));
        StoreReqLine.SETFILTER("Document No.", Rec."No.");
        StoreReqLine.SETFILTER(Type, FORMAT(StoreReqLine.Type::Item));
        StoreReqLine.SETFILTER("Qty. Requested", '>%1', 0);
        StoreReqLine.SETFILTER("Transfer to Item Jnl", '%1', TRUE);
        StoreReqLine.SETFILTER("Qty To Transfer to Item Jnl", '>%1', 0);
        StoreReqLine.SetFilter("Transferred To Item Jnl", '%1', false);
        IF StoreReqLine.FINDFIRST THEN BEGIN
            REPEAT
                StoreReqLine.TestField("Transferred to Job Jnl", false);
                //Check the inventory to see wether there is stock
                OneStoreReqLine.GET(StoreReqLine."Document Type", StoreReqLine."Request Type", StoreReqLine."Document No.", StoreReqLine."Line No.");
                InvtQty := NFLInfoPaneMgt.CalcAvailability2(OneStoreReqLine);
                IF StoreReqLine."Qty To Transfer to Item Jnl" > InvtQty THEN
                    ERROR('Item No %1 in Line No %2 has no sufficient stock in Inventory:Inventory has %3', StoreReqLine."No.",
                    StoreReqLine."Line No.", InvtQty);

                ItemJnlLine.LOCKTABLE;
                CheckItemTracking(StoreReqLine."Line No.");
                ItemJnlLine.RESET;
                ItemJnlLine.INIT;
                ItemJnlLine."Journal Template Name" := JournalTemplate;
                ItemJnlLine."Journal Batch Name" := JournalBatch;
                ItemJnlLine."Line No." := LineNo + 10000;
                ItemJnlLine.validate("Posting Date", WORKDATE);
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine.VALIDATE(ItemJnlLine."Item No.", StoreReqLine."No.");
                ItemJnlLine.Description := StoreReqLine.Description;
                ItemJnlLine.VALIDATE(Quantity, StoreReqLine."Qty To Transfer to Item Jnl");
                ItemJnlLine."Document No." := Rec."No.";
                ItemJnlLine."Location Code" := StoreReqLine."Location Code";
                ItemJnlLine."Unit of Measure Code" := StoreReqLine."Unit of Measure Code";
                ItemJnlLine."G/L Expense A/c" := StoreReqLine."G/L Expense A/c";
                ItemJnlLine."Employee No." := StoreReqLine."Request-By No.";
                ItemJnlLine."Equipment No." := StoreReqLine."Equipment No.";
                ItemJnlLine."Equipment Type" := StoreReqLine."Equipment Type";
                ItemJnlLine.Validate("Dimension Set ID", StoreReqLine."Dimension Set ID");
                lvItem.GET(StoreReqLine."No.");
                IF lvItem."Item for Issue to Employees" THEN
                    ItemJnlLine."Misc. Article Code" := lvItem."Misc. Article Code";

                ItemJnlLine."Misc. Article Code" := lvItem."Misc. Article Code";
                ItemJnlLine."Store Req. No" := StoreReqLine."Document No.";
                ItemJnlLine."From Store Req" := TRUE;
                ItemJnlLine."Store Req. Invt Charge Acc" := StoreReqLine."Inventory Charge A/c";
                LineNo += 10000;
                ItemJnlLine.INSERT;

                StoreReqLine."Total Qty To Item Jnl" += StoreReqLine."Qty To Transfer to Item Jnl";
                StoreReqLine."Transferred To Item Jnl" := true;
                StoreReqLine.MODIFY;
            UNTIL StoreReqLine.NEXT = 0;

            IF lvItemsString <> '' THEN
                MESSAGE('Items %1 have no stock and were not transferred to the Journals. The document was Archived but not Deleted', lvItemsString
               );

            Message := ('Items successfully transferred to the item journal: ' + JournalBatch);

            if Confirm(Message, true) then begin
                ItemJournalLines.SetRange("Journal Template Name", JournalTemplate);
                ItemJournalLines.SetRange("Journal Batch Name", JournalBatch);

                if ItemJnlLine.FindSet() then
                    ItemJnlPost.Run(ItemJnlLine);

                // if ItemJournalLines.FindFirst() then begin
                //     ItemJournalPage.SetTableView(ItemJournalLines); // Filters the view
                //     ItemJournalPage.SetRecord(ItemJournalLines);
                //     ItemJournalPage.Run();
                // end
            end;
        END ELSE
            ERROR('There are no lines to Consume from Stock');
    end;

    /// <summary>
    /// Description for CloseStoreReq.
    /// </summary>
    procedure CloseStoreReq();
    var
        lvStoreReqLine: Record "ADT Requisition Line";
        Close: Boolean;
    begin
        Close := TRUE;
        lvStoreReqLine.SETFILTER("Document Type", FORMAT(lvStoreReqLine."Document Type"::"Store Requisition"));
        lvStoreReqLine.SETFILTER("Document No.", Rec."No.");
        IF lvStoreReqLine.FINDFIRST THEN BEGIN
            REPEAT
                IF Close THEN BEGIN
                    IF (lvStoreReqLine."Total Qty To Item Jnl" + lvStoreReqLine."Total Qty To Purch. Req") < lvStoreReqLine."Qty. Requested"
                    THEN
                        Close := FALSE;
                END;
            UNTIL lvStoreReqLine.NEXT = 0;
        END;
        //delete the record and dimensions
        IF Close THEN BEGIN
            IF lvStoreReqLine.FINDFIRST THEN
                REPEAT
                    DeleteReservationEntries(lvStoreReqLine);
                    lvStoreReqLine.DELETE;
                UNTIL lvStoreReqLine.NEXT = 0;
            Rec.DELETE;
        END;
    end;

    /// <summary>
    /// Description for DeleteReservationEntries.
    /// </summary>
    /// <param name="ReqLine">Parameter of type Record "NFL Requisition Line".</param>
    procedure DeleteReservationEntries(ReqLine: Record "ADT Requisition Line");
    begin
        CLEAR(ReserveMgt);
        //ReserveMgt.SetRequisitionLine(ReqLine); IE
        ReserveMgt.DeleteReservEntries(TRUE, 0);
        CLEAR(ReserveMgt);
    end;

    /// <summary>
    /// Description for CheckItemTracking.
    /// </summary>
    /// <param name="LineNo">Parameter of type Integer.</param>
    procedure CheckItemTracking(LineNo: Integer);
    var
        lvStoreReqLine2: Record "ADT Requisition Line";
        lvItem2: Record Item;
        lvItemTrackingCode: Record "Item Tracking Code";
        ReserveEntry: Record "Reservation Entry";
        QtyCounted: Integer;
    begin
        lvStoreReqLine2.GET(Rec."Document Type", Rec."Request Type", Rec."No.", LineNo);
        lvItem2.GET(lvStoreReqLine2."No.");
        IF lvItem2."Item Tracking Code" <> '' THEN BEGIN
            lvItemTrackingCode.GET(lvItem2."Item Tracking Code");

            ReserveEntry.FILTERGROUP(7);
            // ReserveEntry.SETRANGE("Source Type", DATABASE::Table 51406291); IE
            ReserveEntry.SETRANGE(ReserveEntry."Source Subtype", Rec."Document Type");
            ReserveEntry.SETRANGE(ReserveEntry."Source ID", Rec."No.");
            ReserveEntry.SETFILTER(ReserveEntry."Source Ref. No.", '%1', LineNo);
            QtyCounted := 0;
            //check serial no's
            IF lvItemTrackingCode."SN Neg. Adjmt. Outb. Tracking" THEN BEGIN
                ReserveEntry.FILTERGROUP(8);
                ReserveEntry.SETFILTER(ReserveEntry."Serial No.", '<>%1', '');
                IF ReserveEntry.FINDFIRST THEN
                    REPEAT
                        QtyCounted += ReserveEntry.Quantity;
                    UNTIL ReserveEntry.NEXT = 0;
                // IF lvStoreReqLine2."Qty To Transfer to Item Jnl" <> (-QtyCounted) THEN
                // ERROR('Store Req %1 Line no %2 Item %3 requires serial nos', lvStoreReqLine2."Document No.", lvStoreReqLine2."Line No.",
                // lvStoreReqLine2."No.");
            END;
            //check lot no's
            QtyCounted := 0;
            IF lvItemTrackingCode."Lot Neg. Adjmt. Outb. Tracking" THEN BEGIN
                ReserveEntry.FILTERGROUP(7);
                ReserveEntry.SETFILTER(ReserveEntry."Lot No.", '<>%1', '');
                IF ReserveEntry.FINDFIRST THEN
                    REPEAT
                        QtyCounted += ReserveEntry.Quantity;
                    UNTIL ReserveEntry.NEXT = 0;
                // IF lvStoreReqLine2."Qty To Transfer to Item Jnl" <> (-QtyCounted) THEN
                // ERROR('Store Req %1 Line no %2 Item %3 requires Lot nos', lvStoreReqLine2."Document No.", lvStoreReqLine2."Line No.",
                // lvStoreReqLine2."No.");
            END;
        END;
    end;

    /// <summary>
    /// Description for ShortcutDimension1CodeOnAfterV.
    /// </summary>
    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    /// <summary>
    /// Description for ShortcutDimension2CodeOnAfterV.
    /// </summary>
    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;
}

