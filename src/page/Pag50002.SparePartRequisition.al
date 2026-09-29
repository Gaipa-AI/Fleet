page 50002 "Spare Part Requisition"
{

    Caption = 'Spare Parts Requisition';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTable = "ADT Requisition Header";
    SourceTableView = WHERE("Document Type" = FILTER("Purchase Requisition"), "Request Type" = filter("Spare Parts"));
    Permissions = tabledata "ADT Requisition Header" = rm,
                      tabledata "ADT Requisition Line" = rm,
                      tabledata "Email Related Attachment" = rm,
                      tabledata "Approval Entry" = rimd;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    // Editable = EditPage;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Request-By No."; Rec."Request-By No.")
                {
                    ApplicationArea = All;
                    // Editable = EditPage;
                    Importance = Promoted;
                }
                field("Request-By Name"; Rec."Request-By Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    // Editable = EditPage;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    // Editable = EditPage;
                }
                field("Maintenance Request No."; Rec."Maintenance Request No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance Request No. field.', Comment = '%';
                }
                field("Job Card No."; Rec."Job Card No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    // Editable = EditPage;
                    Importance = Promoted;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = All;
                    Visible = false;
                    // Editable = EditPage;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Wrks/Srvcs/Sup"; Rec."Wrks/Srvcs/Sup")
                {
                    ApplicationArea = All;
                    // Editable = EditPage;
                    Visible = false;
                }
                field("PD Entity"; Rec."PD Entity")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Procurement Plan Reference"; Rec."Procurement Plan Reference")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                group(Dimension)
                {
                    // Editable = EditPage;
                    Caption = 'Dimensions';
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Equipment No."; Rec."Equipment No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Equipment RegNo."; Rec."Equipment RegNo.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }

                    field("Equipment Type"; Rec."Equipment Type")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    Caption = 'Request Reason';
                    // Editable = EditPage;
                    MultiLine = true;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Request Date';
                    // Editable = EditPage;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    // Editable = EditPage;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                    // Editable = EditPage;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    // Editable = EditPage;
                    trigger OnAssistEdit();
                    var
                        lvNFLRequisitionLine: Record "ADT Requisition Line";
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);

                        CLEAR(ChangeExchangeRate);

                    end;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("User ID"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                }
                field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                }
                field("Valid to Date"; Rec."Valid to Date")
                {
                    ApplicationArea = All;
                    Editable = EditPage;
                    Visible = false;
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Transferred to Item Journal';
                }
                field("Converted to Quote"; Rec."Converted to Quote")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                // field("Approvals Entry"; Rec."Approvals Entry")
                // {
                //     ApplicationArea = All;
                // }

                field(Archived; Rec.Archived)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Prepared by"; Rec."Prepared by")
                // {
                //     ApplicationArea = All;
                // }
                field("Requisition Lines Total"; Rec."Requisition Lines Total")
                {
                    ApplicationArea = All;
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                    Editable = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                    Editable = false;
                }
                field("Budget At Date Exceeded"; Rec."Budget At Date Exceeded")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget At Date Exceeded field';
                    Visible = false;
                }
                field("Month Budget Exceeded"; Rec."Month Budget Exceeded")
                {
                    ToolTip = 'Specifies the value of the Month Budget Exceeded field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quarter Budget Exceeded"; Rec."Quarter Budget Exceeded")
                {
                    ToolTip = 'Specifies the value of the Quarter Budget Exceeded field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Year Budget Exceeded"; Rec."Year Budget Exceeded")
                {
                    ToolTip = 'Specifies the value of the Year Budget Exceeded field';
                    ApplicationArea = All;
                    Visible = false;
                }

            }
            part(PurchLines; "Spare Part Requisition Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"ADT Requisition Header"),
                              "No." = FIELD("No.");
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
            group("&Requisition")
            {
                Caption = '&Requisition';
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Employee Card";
                    RunPageLink = "No." = FIELD("Request-By No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Purchase Requisition"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim;
                    end;
                }

                separator(separator)
                {
                }
                group("Cross Referencing")
                {
                    action("Purchase Quote")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Quote';
                        Image = Quote;
                        RunObject = Page "Purchase List";
                        RunPageLink = "Purchase Requisition No." = FIELD("No.");
                        RunPageView = SORTING("Document Type", "No.")
                                      WHERE("Document Type" = CONST(Quote));

                    }
                    action("Purchase Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Orders';
                        RunObject = Page "Purchase List";
                        RunPageLink = "Purchase Requisition No." = FIELD("No.");
                        RunPageView = SORTING("Document Type", "No.")
                                      WHERE("Document Type" = CONST(Order));
                    }
                    action("Purchase Receipts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Receipts';
                        RunObject = Page "Posted Purchase Receipts";
                    }
                    action("Posted Purchase Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Invoices';
                        RunObject = Page "Posted Purchase Invoices";
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction();
                    var
                        lvPurchLine: Record "ADT Requisition Line";
                        lvPurchReqHeader: Record "ADT Requisition Header";
                    begin
                        gvUserSetup.SETRANGE(gvUserSetup."User ID", USERID);
                        IF gvUserSetup.FIND('-') THEN BEGIN
                            IF gvUserSetup."Archive Document" = FALSE THEN
                                ERROR(Text0025);
                        END
                        ELSE
                            ERROR(Text0026);

                        IF CONFIRM(Text0023) THEN BEGIN
                            Rec.TESTFIELD("Converted to Quote", true);
                            Rec.StorePurchDocument(Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
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
                action("Approval Request Entries")
                {
                    ApplicationArea = Basic, Suite;
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    PromotedIsBig = true;
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("No.");
                }
                action("Make Purchase Quote")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Make Purchase Quote';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        PaymentJnl: Record "Gen. Journal Line";
                        NflRequisitionLine: Record "ADT Requisition Line";
                        Int: Integer;
                        n: Integer;
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField("Maintenance Request No.");
                        // Check whether the requisition has not yet been converted to an order.
                        //To check if all lines have been converted into Purchase orders
                        NflRequisitionLine.RESET;
                        NflRequisitionLine.SETRANGE(NflRequisitionLine."Document No.", Rec."No.");
                        Int := NflRequisitionLine.COUNT;
                        FOR n := 1 TO Int DO BEGIN
                            NflRequisitionLine.SETRANGE(Converted, FALSE);
                            IF NflRequisitionLine.FINDFIRST THEN BEGIN
                                IF NflRequisitionLine.Convert = FALSE THEN;
                            END ELSE
                                ERROR('This Purchase Requisition Has been fully converted into an Quote(s)');
                        END;
                        MakePurchaseQuote();


                    end;
                }
                action("Make Order from All Requisitions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Make Order from All Requisitions';
                    Visible = false;

                    trigger OnAction();
                    var
                        lvMyForm: Page "Create Orders from Requisition";
                        lvPurchaseOrderLine: Record "ADT Requisition Line";
                    begin
                        lvPurchaseOrderLine.SETFILTER("Document Type", FORMAT(lvPurchaseOrderLine."Document Type"::"Purchase Requisition"));
                        lvMyForm.SETTABLEVIEW(lvPurchaseOrderLine);
                        lvMyForm.GetVendorCode(Rec."Buy-from Vendor No.");
                        lvMyForm.RUNMODAL;
                    end;
                }
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
                        Rec.TestField("Maintenance Request No.");
                        IF CONFIRM('Are you sure you want to transfer these lines to Item journal?') THEN BEGIN
                            if Rec."Request Type" = Rec."Request Type"::Fuel then begin
                                ANFSetup.GET;
                                ANFSetup.TESTFIELD("Fuel Req Item Jnl Template");
                                ANFSetup.TESTFIELD("Fuel Req Item Jnl Batch");
                                TransferSpareToItemJnl(ANFSetup."Fuel Req Item Jnl Template", ANFSetup."Fuel Req Item Jnl Batch");
                                Rec.ArchiveStoreRequisition();
                            end else if Rec."Request Type" = Rec."Request Type"::General then begin
                                ANFSetup.GET;
                                ANFSetup.TESTFIELD("Store Req Item Jnl Template");
                                ANFSetup.TESTFIELD("Store Req Item Jnl Batch");
                                TransferSpareToItemJnl(ANFSetup."Store Req Item Jnl Template", ANFSetup."Store Req Item Jnl Batch");
                                Rec.ArchiveStoreRequisition();
                            end else if Rec."Request Type" = Rec."Request Type"::"Spare Parts" then begin
                                ANFSetup.GET;
                                ANFSetup.TESTFIELD("Spare Req Item Jnl Template");
                                ANFSetup.TESTFIELD("Spare Req Item Jnl Batch");
                                TransferSpareToItemJnl(ANFSetup."Spare Req Item Jnl Template", ANFSetup."Spare Req Item Jnl Batch");
                                Rec.ArchiveStoreRequisition();
                            end
                        END;
                    end;
                }

                separator("....")
                {
                }
                action("Make RFQ")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Make RFQ';
                    Image = Quote;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction();
                    var
                        BankReconn: Record "Bank Acc. Reconciliation";
                        PaymentJnl: Record "Gen. Journal Line";
                    begin
                        //Check whether the requisition has not yet been converted to an order.
                        IF Rec."Converted to Quote" = TRUE THEN
                            ERROR('The purchase requisition has already been converted to a quote.');
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                        RequisitionHeader: Record "ADT Requisition Header";
                        RptPurchaseRequisition: Report "Spare Parts Requisition";
                    begin
                        RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Purchase Requisition");
                        RequisitionHeader.SETRANGE("No.", Rec."No.");
                        RptPurchaseRequisition.SETTABLEVIEW(RequisitionHeader);
                        RptPurchaseRequisition.RUNMODAL;
                    end;
                }
                action("Detail Commitment Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Detail Commitment Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;
                }
                action("Form 5")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Form 5';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction();
                    var
                        RequisitionHeader: Record "ADT Requisition Header";
                    begin
                        RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Purchase Requisition");
                        RequisitionHeader.SETRANGE("No.", Rec."No.");
                        ReptForm5.SETTABLEVIEW(RequisitionHeader);
                        ReptForm5.RUNMODAL;
                        CLEAR(ReptForm5);
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
                    begin
                        Rec.CalcFields("Requisition Lines Total");
                        Rec.TestField("Location Code");
                        Rec.TESTFIELD("Request-By No.");
                        Rec.TESTFIELD("Posting Date");
                        Rec.TESTFIELD("Shortcut Dimension 1 Code");
                        Rec.TESTFIELD("Order Date");
                        Rec.TESTFIELD("Document Date");
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Maintenance Request No.");

                        CheckSparePartsLinesLocation(Rec."No.");

                        IF Rec."Prepared by" <> USERID THEN
                            ERROR('The selected request can only be sent for approval by the initiator %1', Rec."Prepared by");

                        IF Rec."Posting Description" = '' THEN
                            ERROR('Please specify the subject of Procurement');

                        if Confirm('Are you sure you want to send this Approval Request ?', true) then begin
                            if ApprovalsMgmtCut.CheckClaimApprovalsWorkflowEnablePRQ(Rec) then begin
                                ApprovalsMgmtCut.OnSendClaimForApprovalPRQ(Rec);
                                customCodeunit.modifyApprovalEntryPRQ(Rec);
                            end;
                            //Rec.SendRequisitionApprovedEmail(Rec)
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
                        CUstp: Record "User Setup";
                        ApprovalEntry: Record "Approval Entry";
                        PR: Page "Spare Part Requisition";
                    begin
                        Rec.TestField("Maintenance Request No.");
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        if Rec."Converted to Quote" = TRUE then
                            ERROR('The purchase requisition has already been converted to a Quote');
                        IF Rec."Prepared by" <> USERID THEN BEGIN
                            CUstp.SETRANGE(CUstp."User ID", USERID);
                            IF CUstp.FIND('-') THEN BEGIN
                                IF CUstp."Voucher Admin" = FALSE THEN
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
                            PR.MakePageEditable();
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
                        Rec.TestField("Maintenance Request No.");
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
                        ADTLine: Record "ADT Requisition Line";
                    begin
                        if Rec.Status = Rec.Status::Released then
                            Error('This document is already released');
                        if Rec.Status = Rec.Status::Open then
                            Error('Document Status must be set to Pending Approval');

                        Rec.TestField("Location Code");
                        Rec.TestField("Requisition Lines Total");
                        Rec.TestField("Maintenance Request No.");


                        ClaimCount := 0;
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange(ApprovalEntry."Document No.", Rec."No.");
                        ApprovalEntry.SetRange(ApprovalEntry."Approval Type", ApprovalEntry."Approval Type"::Approver);
                        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
                        if ApprovalEntry.FindFirst() then begin
                            ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        end
                        else begin
                            if Rec."Request Type" = Rec."Request Type"::General then begin
                                UserSetup.Reset();
                                UserSetup.SetRange(UserSetup."User ID", UserId);
                                UserSetup.SetRange(UserSetup."SBU Head", true);
                                if UserSetup.FindFirst() then begin
                                    ApprovalDoc.CheckBudgetPurchasePRQ(Rec);
                                end;
                            end;

                            ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                            Rec.ReleaseTheApprovedDoc();
                        end;
                        //Send email implemented
                        customFunction.OpenApprovalEntriesPRQ(Rec);
                        Rec.CheckDocumentRelease(Rec);
                        Rec.SendRequisitionApprovedEmail(Rec);
                    end;
                }
                action(Refresh)
                {
                    ApplicationArea = All;
                    Caption = 'Refresh';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
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
                        Rec.TestField("Maintenance Request No.");
                        if Confirm('Are you sure you want to Reject this Requisition ?', true) then begin
                            //Checking for comments before rejecting
                            // ApprovalComments.Reset();
                            // ApprovalComments.SetRange(ApprovalComments."No.", Rec."No.");
                            // ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Purchase Requisition");
                            if ApprovalComments.FindFirst() then begin
                                ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                                Rec.Status := Rec.Status::Rejected;
                                customFunction.RejectApprovalRequestPRQ(Rec);
                                //Rec.SendRejectEmail(Rec);
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
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    var
                        Txt002: Label 'Are you sure you want to Escalate this document ?';
                        CustomFunctionApproval: Codeunit "Fleet Management";
                    begin
                        Rec.TestField("Maintenance Request No.");
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
                        Rec.TestField("Maintenance Request No.");
                        if Confirm(Txt002, true) then begin
                            CustomPurchFunction.DelegatePurchaseApprovalRequestPRQ(Rec);
                            Rec.SendRequisitionApprovedEmail(Rec);
                        end;
                    end;
                }
            }

        }
    }

    trigger OnAfterGetCurrRecord();
    var
        lvNFLRequisitionLine: Record "ADT Requisition Line";
    begin
    end;

    trigger OnAfterGetRecord();
    var
        lvNFLRequisitionLine: Record "ADT Requisition Line";
    begin
        OpenApprovalEntriesExistForcurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    trigger OnDeleteRecord(): Boolean;
    begin

        Rec.TESTFIELD(Status, Rec.Status::Open);
        // CurrPage.SAVERECORD;
        // EXIT(Rec.ConfirmDeletion);
    end;

    trigger OnInit();
    begin
        PurchHistoryBtn1Visible := TRUE;
        PayToCommentBtnVisible := TRUE;
        PayToCommentPictVisible := TRUE;
        PurchHistoryBtnVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage();
    var
        lvNFLRequisitionLine: Record "ADT Requisition Line";
        UserSetup: Record "User Setup";
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;

        EditFields;

        IF Rec.Status IN [Rec.Status::Released, Rec.Status::"Pending Approval"] THEN
            EditPage := FALSE
        ELSE
            EditPage := TRUE;

        //Validate budget checks.
        lvNFLRequisitionLine.RESET;
        lvNFLRequisitionLine.SETRANGE("Document No.", Rec."No.");
        lvNFLRequisitionLine.LOCKTABLE;
        IF lvNFLRequisitionLine.FIND('-') THEN
            REPEAT
                lvNFLRequisitionLine."Accounting Period Start Date" := Rec."Accounting Period Start Date";
                lvNFLRequisitionLine."Accounting Period End Date" := Rec."Accounting Period End Date";
                lvNFLRequisitionLine."Fiscal Year Start Date" := Rec."Fiscal Year Start Date";
                lvNFLRequisitionLine."Fiscal Year End Date" := Rec."Fiscal Year End Date";
                lvNFLRequisitionLine."Filter to Date Start Date" := Rec."Filter to Date Start Date";
                lvNFLRequisitionLine."Filter to Date End Date" := Rec."Filter to Date End Date";
                lvNFLRequisitionLine."Quarter Start Date" := Rec."Quarter Start Date";
                lvNFLRequisitionLine."Quarter End Date" := Rec."Quarter End Date";
                lvNFLRequisitionLine.VALIDATE("Filter to Date Start Date");
                lvNFLRequisitionLine.VALIDATE("Filter to Date End Date");
                lvNFLRequisitionLine.VALIDATE("Fiscal Year Start Date");
                lvNFLRequisitionLine.VALIDATE("Fiscal Year End Date");
                lvNFLRequisitionLine.VALIDATE("Quarter Start Date");
                lvNFLRequisitionLine.VALIDATE("Quarter End Date");
                lvNFLRequisitionLine.VALIDATE("Accounting Period Start Date");
                lvNFLRequisitionLine.VALIDATE("Accounting Period End Date");
                lvNFLRequisitionLine.MODIFY;
            UNTIL lvNFLRequisitionLine.NEXT = 0;

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
        PurchaseReqLine.UpdateAvailableQuantity();
        PurchaseReqLine.UpdateAvailableQuantityLocation();
    end;

    local procedure CheckSparePartsLinesLocation(DocumentNo: Code[20])
    var
        RequisitionLine: Record "ADT Requisition Line";
    begin
        RequisitionLine.SetRange("Document Type", RequisitionLine."Document Type"::"Purchase Requisition");
        RequisitionLine.SetRange("Request Type", RequisitionLine."Request Type"::"Spare Parts");
        RequisitionLine.SetRange("Document No.", DocumentNo);

        if RequisitionLine.FindSet() then
            repeat
                if RequisitionLine."Location Code" = '' then
                    Error('Line %1 must have a Location Code before sending the request for approval.', RequisitionLine."Line No.");
            until RequisitionLine.Next() = 0;
    end;


    var
        PurchSetup: Record "Purchases & Payables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        // ArchiveManagement: Codeunit "NFL ArchiveManagement"; TODO:Review
        PurchInfoPaneMgmt: Codeunit "Fleet Management";
        Text000: Label 'Do you want to convert the Requisition to a Quote?';
        Text001: Label 'Requisition number %1 has been converted to Quote number %2.';
        PurchQuoteHeader: Record "Purchase Header";
        PurchQuoteLine: Record "Purchase Line";
        DocDim: Codeunit "DimensionManagement";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        PrepmtMgt: Codeunit "Prepayment Mgt.";
        PurchDocLineComment: Record "Purch. Comment Line";
        PurchCommentLine: Record "Purch. Comment Line";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        PurchReqLine: Record "ADT Requisition Line";
        PurchReqHeader: Record "ADT Requisition Header";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        i: Integer;
        DocNo: array[30] of Code[20];
        Text002: Label 'Requisition number %1 has been converted to Quote Numbers %2 - %3';
        PurchaseReqLine: Record "ADT Requisition Line";
        Text003: Label 'Do you want to convert the Requisition to an Order?';
        Text004: Label 'Requisition number %1 has been converted to Quote number %2.';
        Text005: Label 'Requisition number %1 has been converted to Quotes Number %2 - %3';
        ANFSetup: Record "Fleet Management Setup";
        PurchHistoryBtnVisible: Boolean;
        PayToCommentPictVisible: Boolean;
        PayToCommentBtnVisible: Boolean;
        PurchHistoryBtn1Visible: Boolean;
        StoreReqLine: Record "ADT Requisition Line";
        Text19023272: Label 'Buy-from Vendor';
        Text19005663: Label 'Pay-to Vendor';
        CurrencyFactor: Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        gvPurchLine: Record "Purchase Line";
        NFLRequisitionLine: Record "ADT Requisition Line";
        gvNFLRequisitionLine: Record "ADT Requisition Line";
        ShortcutDimCode: array[9] of Code[20];
        PurchOrderNo: Code[20];
        gvHeaderTotal: Decimal;
        Text0022: Label 'There must be atleast one line with amount in the Purchase requisition Details Subform';
        Text0023: Label 'Are you sure you want to archive this document ?';
        Text0024: Label 'Please confirm archival and deletion of this document.';
        gvUserSetup: Record "User Setup";
        Text0025: Label 'You do not have permissions to archive this document, please consult the Admin';
        Text0026: Label 'You do not exist in the user setup,  please contact the Admin';
        EditPage: Boolean;
        ReptForm5: Report "Form 5";
        Edit: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ViewCancel: Boolean;
        ApprovalsMgmtCut: Codeunit "Fleet Management";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        OpenApprovalEntriesExistForcurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanCancelApprovalForFlow: Boolean;
        CanRequestApprovalForFlow: Boolean;
        sendApprovalRequest: Boolean;
        CancelApprovalVisible: Boolean;
        StatusPending: Boolean;
        ItemJnlLine: Record "Item Journal Line";
        customFunction: Codeunit "Fleet Management";

    procedure MakePageEditable()
    var
        myInt: Integer;
    begin
        EditPage := true;
    end;

    /// <summary>
    /// Description for UpdateInfoPanel.
    /// </summary>
    local procedure UpdateInfoPanel();
    var
        DifferBuyFromPayTo: Boolean;
    begin
        DifferBuyFromPayTo := Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.";
        PurchHistoryBtnVisible := DifferBuyFromPayTo;
        PayToCommentPictVisible := DifferBuyFromPayTo;
        PayToCommentBtnVisible := DifferBuyFromPayTo;
        PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec, Rec."Buy-from Vendor No.");
        IF DifferBuyFromPayTo THEN
            PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec, Rec."Pay-to Vendor No.")
    end;

    /// <summary>
    /// Description for TransferToItemJnl.
    /// </summary>
    procedure TransferSpareToItemJnl(JournalTemplate: Code[50]; JournalBatch: Code[50]);
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SourceCodeSetup: Record "Source Code Setup";
        LineNo: Integer;
        PurchPaySetup: Record "Purchases & Payables Setup";
        lvItem: Record Item;
        lvItemsString: Text[250];
        lvBoolDelete: Boolean;
        FromType: Option " ",ItemJnl,PurchaseReq;
        ItemJnlLine2: Record "Item Journal Line";
        FirstLineNo: Integer;
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
        CheckApplFromItemEntry: Boolean;
        InvtQty: Decimal;
        NFLInfoPaneMgt: Codeunit "Fleet Management";
        OneStoreReqLine: Record "ADT Requisition Line";
        RequisitionHeader: Record "ADT Requisition Header";
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
        StoreReqLine.SETFILTER("Document Type", FORMAT(StoreReqLine."Document Type"::"Purchase Requisition"));
        StoreReqLine.SETFILTER("Document No.", Rec."No.");
        StoreReqLine.SETFILTER(Type, FORMAT(StoreReqLine.Type::Item));
        StoreReqLine.SETFILTER("Qty. Requested", '>%1', 0);
        StoreReqLine.SETFILTER("Transfer to Item Jnl", '%1', TRUE);
        StoreReqLine.SETFILTER("Qty To Transfer to Item Jnl", '>%1', 0);
        StoreReqLine.SetFilter("Transferred To Item Jnl", '%1', false);
        //StoreReqLine.SetFilter("Avail Qty AtCurrentLocation", '>=%1', StoreReqLine."Quantity");
        IF StoreReqLine.FINDFIRST THEN BEGIN
            REPEAT
                StoreReqLine.TestField("Transferred to Job Jnl", false);
                StoreReqLine.TestField("Posting Date");
                //Check the inventory to see wether there is stock
                OneStoreReqLine.GET(StoreReqLine."Document Type", StoreReqLine."Request Type", StoreReqLine."Document No.", StoreReqLine."Line No.");
                InvtQty := NFLInfoPaneMgt.CalcAvailability2(OneStoreReqLine);
                //InvtQty := StoreReqLine."Currentstock";
                IF StoreReqLine."Quantity" > InvtQty then
                    ERROR('Item No %1 %2 has no sufficient stock at that location %4 in Inventory:Inventory has %3 first purchase items using action Make Purchase Quote', StoreReqLine."No.",
                    StoreReqLine."Description", InvtQty, StoreReqLine."Location Code");
                IF StoreReqLine."Qty To Transfer to Item Jnl" > InvtQty THEN
                    ERROR('Item No %1 %2 has no sufficient stock in Inventory:Inventory has %3 at location %4 regarding only quantity requested to be transferred', StoreReqLine."No.",
                    StoreReqLine."Description", InvtQty, StoreReqLine."Location Code");


                RequisitionHeader.Get(StoreReqLine."Document Type", StoreReqLine."Request Type", StoreReqLine."Document No.");

                ItemJnlLine.LOCKTABLE;
                CheckItemTracking(StoreReqLine."Line No.");
                ItemJnlLine.RESET;
                ItemJnlLine.INIT;
                ItemJnlLine."Journal Template Name" := JournalTemplate;
                ItemJnlLine."Journal Batch Name" := JournalBatch;
                ItemJnlLine."Line No." := LineNo + 10000;
                ItemJnlLine.validate("Posting Date", StoreReqLine."Posting Date");
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
                ItemJnlLine."Responsible Employee" := RequisitionHeader."Responsible Employee";
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
    /// Description for PurchReqtoQuote(Y/N.
    /// </summary>
    /// <param name="(var Rec">VAR Record "ADT Requisition Header".</param>
    procedure "PurchReqtoQuote(Y/N)"(var Rec: Record "ADT Requisition Header");
    begin
        Rec.TESTFIELD("Document Type", Rec."Document Type"::"Purchase Requisition");
        IF NOT CONFIRM(Text000, FALSE) THEN
            EXIT;

        PurchReqtoQuote(Rec);
        GetPurchQuoteHeader(PurchQuoteHeader);

        IF i = 1 THEN BEGIN
            MESSAGE(Text001,
                Rec."No.", PurchQuoteHeader."No.");
            Rec.VALIDATE("Converted to Quote", TRUE);
        END ELSE BEGIN
            MESSAGE(Text002,
                Rec."No.", DocNo[1], DocNo[i]);
            Rec.VALIDATE("Converted to Quote", TRUE);
        END;
    end;

    /// <summary>
    /// Description for PurchReqtoQuote.
    /// </summary>
    /// <param name="Rec">Parameter of type Record "ADT Requisition Header".</param>
    procedure PurchReqtoQuote(var Rec: Record "ADT Requisition Header");
    var
        OldPurchCommentLine: Record "Purch. Comment Line";
        Vend: Record Vendor;
        PrevVendorNo: Code[20];
        LineNo: Integer;
        NextDocNo: Code[20];
    begin
        //NEW CODE FOR THE PURCHASE REQUISITION
        Rec.TESTFIELD("Document Type", Rec."Document Type"::"Purchase Requisition");
        PurchSetup.GET;
        PurchaseReqLine.RESET;
        PurchaseReqLine.SETCURRENTKEY(PurchaseReqLine."Buy-from Vendor No.");
        PurchaseReqLine.SETRANGE(PurchaseReqLine."Document Type", Rec."Document Type");
        PurchaseReqLine.SETFILTER(PurchaseReqLine."Document No.", '%1', Rec."No.");

        i := 0;    //to capture the first number
        PrevVendorNo := '';
        CLEAR(DocNo);
        IF PurchaseReqLine.FINDFIRST THEN BEGIN
            REPEAT
                PurchaseReqLine.TESTFIELD(PurchaseReqLine."Buy-from Vendor No.");
                IF PurchaseReqLine."Buy-from Vendor No." <> PrevVendorNo THEN BEGIN  //create new header
                    Vend.GET(PurchaseReqLine."Buy-from Vendor No.");
                    Vend.CheckBlockedVendOnDocs(Vend, FALSE);
                    PurchQuoteHeader.INIT;
                    NextDocNo := NoSeriesMgt.GetNextNo(PurchSetup."Quote Nos.", TODAY, TRUE);
                    PurchQuoteHeader."No." := NextDocNo;

                    PurchQuoteHeader."Document Type" := PurchQuoteHeader."Document Type"::Quote;
                    PurchQuoteHeader."Buy-from Vendor No." := PurchaseReqLine."Buy-from Vendor No.";

                    PurchQuoteHeader."No. Printed" := 0;
                    PurchQuoteHeader."Store Requisition No." := Rec."Store Requisition No.";
                    PurchQuoteHeader."Purchase Requisition No." := Rec."No.";
                    PurchQuoteHeader.Status := PurchQuoteHeader.Status::Open;
                    PurchQuoteHeader."Order Date" := Rec."Order Date";
                    IF Rec."Posting Date" <> 0D THEN
                        PurchQuoteHeader."Posting Date" := Rec."Posting Date";
                    PurchQuoteHeader."Document Date" := Rec."Document Date";
                    PurchQuoteHeader."Purchase Requisition No." := Rec."No.";
                    PurchQuoteHeader."Expected Receipt Date" := Rec."Expected Receipt Date";
                    PurchQuoteHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                    PurchQuoteHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                    PurchQuoteHeader."Dimension Set ID" := Rec."Dimension Set ID";
                    PurchQuoteHeader.VALIDATE("Posting Description", Rec."Posting Description");

                    PurchQuoteLine.LOCKTABLE;
                    PurchQuoteHeader.INSERT(TRUE);
                    PurchQuoteHeader.VALIDATE(PurchQuoteHeader."Buy-from Vendor No.");
                    //Transfer dimension to the purchase header.
                    PurchQuoteHeader.VALIDATE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    PurchQuoteHeader.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    PurchQuoteHeader.VALIDATE("Dimension Set ID", Rec."Dimension Set ID");
                    // END.
                    PurchQuoteHeader.MODIFY;
                    LineNo := 0;
                    i += 1;
                    DocNo[i] := PurchQuoteHeader."No.";
                END;
                LineNo += 10000;
                PurchQuoteLine.TRANSFERFIELDS(PurchaseReqLine);
                PurchQuoteLine."Commitment Entry No." := PurchaseReqLine."Commitment Entry No.";

                PurchQuoteLine."Document Type" := PurchQuoteLine."Document Type"::Quote;

                PurchQuoteLine."Document No." := NextDocNo;
                PurchQuoteLine."Line No." := LineNo;
                Rec."Dimension Set ID" := PurchaseReqLine."Dimension Set ID";

                PrevVendorNo := PurchaseReqLine."Buy-from Vendor No.";

                PurchQuoteLine.INSERT(TRUE);
                PrevVendorNo := PurchaseReqLine."Buy-from Vendor No.";
            UNTIL PurchaseReqLine.NEXT = 0;

            //NV requires that once requisition are
            // approved. All orders that originate from such requisitions must be approved as well.
            PurchQuoteHeader.Status := Rec.Status::Released;
            PurchQuoteHeader.MODIFY;
            //
        END;
        COMMIT;

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
                IF lvStoreReqLine2."Qty To Transfer to Item Jnl" <> (-QtyCounted) THEN
                    ERROR('Store Req %1 Line no %2 Item %3 requires serial nos', lvStoreReqLine2."Document No.", lvStoreReqLine2."Line No.",
                    lvStoreReqLine2."No.");
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
                IF lvStoreReqLine2."Qty To Transfer to Item Jnl" <> (-QtyCounted) THEN
                    ERROR('Store Req %1 Line no %2 Item %3 requires Lot nos', lvStoreReqLine2."Document No.", lvStoreReqLine2."Line No.",
                    lvStoreReqLine2."No.");
            END;
        END;
    end;

    /// <summary>
    /// Description for GetPurchQuoteHeader.
    /// </summary>
    /// <param name="PurchHeader">Parameter of type Record "Purchase Header".</param>
    procedure GetPurchQuoteHeader(var PurchHeader: Record "Purchase Header");
    begin
        PurchHeader := PurchQuoteHeader;
    end;

    /// <summary>
    /// Description for MakePurchOrder.
    /// </summary>
    procedure MakePurchOrder();
    var
        PurchaseOrderHdr: Record "Purchase Header";
        PurchaseOrderLine: Record "Purchase Line";
        PurchaseOrderLine2: Record "ADT Requisition Line";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        LineNo: Integer;
        OldPurchCommentLine: Record "Purch. Comment Line";
        Vend: Record Vendor;
        PrevVendorNo: Code[20];
        NextDocNo: Code[20];
        NFLRequisitionLine: Record "ADT Requisition Line";
        lvPurchaseHeader: Record "Purchase Header";
        lvPurchLine: Record "ADT Requisition Line";
        partialOrder: Boolean;
        NflReqnLine3: Record "ADT Requisition Line";
        m: Integer;
        Int3: Integer;
    begin
        IF NOT CONFIRM(Text003, FALSE) THEN
            EXIT;

        PurchSetup.GET;
        PurchaseReqLine.RESET;
        PurchaseReqLine.SETCURRENTKEY("Buy-from Vendor No.");
        PurchaseReqLine.SETRANGE("Document Type", Rec."Document Type"::"Purchase Requisition");
        PurchaseReqLine.SETRANGE(Convert, TRUE);
        PurchaseReqLine.SETRANGE(Converted, FALSE);
        PurchaseReqLine.SETFILTER("Document No.", Rec."No.");

        //To ensure that at least a line is selected to be converted into an order
        IF NOT PurchaseReqLine.FIND('-') THEN
            ERROR('Select the lines you want to convert into an order')
        ELSE
            ;

        i := 0;    //to capture the first number
        PrevVendorNo := '';
        CLEAR(DocNo);
        IF PurchaseReqLine.FINDFIRST THEN BEGIN
            REPEAT
                PurchaseReqLine.TestField("Transfer to Job Jnl", false);
                PurchaseReqLine.TESTFIELD(PurchaseReqLine."Buy-from Vendor No.");
                IF PurchaseReqLine."Buy-from Vendor No." <> PrevVendorNo THEN   //create new header
                  BEGIN
                    Vend.GET(PurchaseReqLine."Buy-from Vendor No.");
                    Vend.CheckBlockedVendOnDocs(Vend, FALSE);
                    PurchaseOrderHdr.INIT;
                    NextDocNo := NoSeriesMgt.GetNextNo(PurchSetup."Order Nos.", TODAY, TRUE);
                    PurchaseOrderHdr."No." := NextDocNo;

                    PurchaseOrderHdr."Document Type" := PurchaseOrderHdr."Document Type"::Order;
                    PurchaseOrderHdr."Buy-from Vendor No." := PurchaseReqLine."Buy-from Vendor No.";
                    PurchaseOrderHdr."No. Printed" := 0;
                    PurchaseOrderHdr."Store Requisition No." := Rec."Store Requisition No.";
                    PurchaseOrderHdr."Purchase Requisition No." := Rec."No.";
                    PurchaseOrderHdr.Status := PurchaseOrderHdr.Status::Open;
                    PurchaseOrderHdr."Order Date" := Rec."Order Date";

                    PurchaseOrderHdr.InitRecord;
                    PurchOrderNo := PurchaseOrderHdr."No.";
                    PurchaseOrderHdr.VALIDATE("Posting Description", Rec."Posting Description");
                    PurchaseOrderHdr."Equipment No." := Rec."Equipment No.";
                    PurchaseOrderHdr."Equipment Type" := Rec."Equipment Type";
                    PurchaseOrderHdr."Responsible Employee" := Rec."Responsible Employee";
                    PurchaseOrderHdr."Dimension Set ID" := Rec."Dimension Set ID";

                    IF Rec."Posting Date" <> 0D THEN
                        PurchaseOrderHdr."Posting Date" := Rec."Posting Date";
                    PurchaseOrderHdr."Document Date" := Rec."Document Date";
                    PurchaseOrderHdr."Purchase Requisition No." := Rec."No.";
                    PurchaseOrderHdr."Expected Receipt Date" := Rec."Expected Receipt Date";
                    PurchaseOrderHdr."Currency Code" := Rec."Currency Code";


                    PurchaseOrderHdr.INSERT(TRUE);
                    //  Transfer dimension to the purchase header.
                    PurchaseOrderHdr.VALIDATE(PurchaseOrderHdr."Buy-from Vendor No.");
                    PurchaseOrderHdr.VALIDATE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    PurchaseOrderHdr.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    PurchaseOrderHdr.VALIDATE("Dimension Set ID", Rec."Dimension Set ID");
                    PurchaseOrderHdr.VALIDATE("Currency Code", Rec."Currency Code");
                    PurchaseOrderHdr."Posting Description" := Rec."Posting Description";
                    //END.

                    PurchaseOrderHdr.MODIFY;
                    LineNo := 0;
                    i += 1;
                    DocNo[i] := PurchaseOrderHdr."No.";

                    //Insert the Line Item Line
                    PurchaseOrderLine2.RESET;
                    PurchaseOrderLine2.SETFILTER("Document Type", FORMAT(PurchaseOrderLine2."Document Type"::"Purchase Requisition"));
                    PurchaseOrderLine2.SETFILTER("Buy-from Vendor No.", PurchaseReqLine."Buy-from Vendor No.");
                    PurchaseOrderLine2.SETFILTER(PurchaseOrderLine2."Document No.", Rec."No.");
                    PurchaseOrderLine2.SETRANGE(Convert, TRUE);
                    PurchaseOrderLine2.SETRANGE(Converted, FALSE);
                    IF PurchaseOrderLine2.FINDSET THEN
                        REPEAT
                            LineNo += 10000;
                            PurchaseOrderLine.LOCKTABLE;
                            PurchaseOrderLine.INIT;

                            PurchaseOrderLine."Document Type" := PurchaseOrderLine."Document Type"::Order;
                            PurchaseOrderLine."Document No." := NextDocNo;
                            PurchaseOrderLine."Line No." := LineNo;
                            PurchaseOrderLine.VALIDATE("Buy-from Vendor No.", PurchaseOrderLine2."Buy-from Vendor No.");
                            PurchaseOrderLine.Type := PurchaseOrderLine2.Type;
                            PurchaseOrderLine.VALIDATE("No.", PurchaseOrderLine2."No.");
                            PurchaseOrderLine.Description := PurchaseOrderLine2.Description;
                            PurchaseOrderLine."Location Code" := PurchaseOrderLine2."Location Code";
                            PurchaseOrderLine.VALIDATE("Currency Code", PurchaseOrderLine2."Currency Code");
                            PurchaseOrderLine.VALIDATE("Dimension Set ID", PurchaseOrderLine2."Dimension Set ID");
                            PurchaseOrderLine.VALIDATE(Quantity, PurchaseOrderLine2.Quantity);
                            PurchaseOrderLine."Unit of Measure" := PurchaseOrderLine2."Unit of Measure";
                            PurchaseOrderLine.validate("Direct Unit Cost", PurchaseOrderLine2."Direct Unit Cost");
                            PurchaseOrderLine."Unit Cost (LCY)" := PurchaseOrderLine2."Unit Cost (LCY)";
                            PurchaseOrderLine.validate("VAT Prod. Posting Group", PurchaseOrderLine2."VAT Prod. Posting Group");
                            PurchaseOrderLine.validate("VAT Bus. Posting Group", PurchaseOrderLine2."VAT Bus. Posting Group");

                            PurchaseOrderHdr.VALIDATE("No.", Rec."No.");
                            PurchaseOrderLine.VALIDATE(Quantity, PurchaseOrderLine2."Qty. to Order");
                            partialOrder := TRUE;
                            PurchaseOrderLine."Control Account" := PurchaseOrderLine2."Control Account";
                            PurchaseOrderLine."Commitment Entry No." := PurchaseOrderLine2."Commitment Entry No.";
                            PurchaseOrderLine."Commitment Budget" := PurchaseOrderLine2."Budget Code";
                            PurchaseOrderLine."Deferral Code" := PurchaseOrderLine2."Deferral Code";
                            PurchaseOrderLine."Equipment No." := PurchaseOrderLine2."Equipment No.";
                            PurchaseOrderLine."Equipment Type" := PurchaseOrderLine2."Equipment Type";
                            PurchaseOrderLine."Responsible Employee" := Rec."Responsible Employee";

                            PurchaseOrderLine.INSERT(TRUE);
                            PurchaseOrderLine."Gen. Bus. Posting Group" := PurchaseOrderHdr."Gen. Bus. Posting Group";
                            PurchaseOrderLine.MODIFY;


                            PurchaseOrderLine2.Converted := TRUE;
                            PurchaseOrderLine2.MODIFY;

                        UNTIL PurchaseOrderLine2.NEXT = 0;

                    lvPurchaseHeader.GET(lvPurchaseHeader."Document Type"::Order, PurchOrderNo);
                    lvPurchaseHeader.Status := Rec.Status::Released;
                    lvPurchaseHeader.MODIFY;
                    Rec."Dimension Set ID" := PurchaseReqLine."Dimension Set ID";


                    PrevVendorNo := PurchaseReqLine."Buy-from Vendor No.";


                END;
            UNTIL PurchaseReqLine.NEXT = 0;
        END;

        ANFSetup.GET;

        COMMIT;

        //Confirmation message
        IF i = 1 THEN BEGIN
            MESSAGE(Text004,
                Rec."No.", DocNo[1]);
            Rec."Converted to Order" := TRUE;
            Rec.Archived := true;
            Rec.MODIFY;
        END ELSE BEGIN
            MESSAGE(Text005,
                Rec."No.", DocNo[1], DocNo[i]);
            Rec."Converted to Order" := TRUE;
            Rec.Archived := true;
            Rec.MODIFY;
        END;
        // Achieve the requisition after converting it to an order.
        //To Archive only if all lines have been coverted into orders
        NflReqnLine3.Reset();
        NflReqnLine3.SetRange(NflReqnLine3."Document No.", Rec."No.");
        NflReqnLine3.SetRange(NflReqnLine3.Converted, false);
        if NflReqnLine3.FindFirst() then
            exit
        else begin
            if ANFSetup."Archive Purch. Requisition" then begin
                CurrPage.UPDATE(FALSE);
                lvPurchLine.SETFILTER("Document Type", FORMAT(Rec."Document Type"::"Purchase Requisition"));
                lvPurchLine.SETFILTER("Document No.", Rec."No.");
                IF lvPurchLine.FINDFIRST THEN;
            end;
        end;
    end;

    procedure MakePurchaseQuote();
    var
        PurchaseOrderHdr: Record "Purchase Header";
        PurchaseOrderLine: Record "Purchase Line";
        PurchaseOrderLine2: Record "ADT Requisition Line";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        LineNo: Integer;
        OldPurchCommentLine: Record "Purch. Comment Line";
        Vend: Record Vendor;
        PrevVendorNo: Code[20];
        NextDocNo: Code[20];
        NFLRequisitionLine: Record "ADT Requisition Line";
        lvPurchaseHeader: Record "Purchase Header";
        lvPurchLine: Record "ADT Requisition Line";
        partialOrder: Boolean;
        NflReqnLine3: Record "ADT Requisition Line";
        m: Integer;
        Int3: Integer;
        PurchaseHeader: Record "Purchase Header";
    begin
        IF NOT CONFIRM(Text003, FALSE) THEN
            EXIT;

        PurchSetup.GET;
        PurchSetup.TestField("Quote Nos.");
        PurchaseReqLine.RESET;
        PurchaseReqLine.SETCURRENTKEY("Buy-from Vendor No.");
        PurchaseReqLine.SETRANGE("Document Type", Rec."Document Type"::"Purchase Requisition");
        PurchaseReqLine.SETRANGE(Convert, TRUE);
        PurchaseReqLine.SETRANGE(Converted, FALSE);
        PurchaseReqLine.SETFILTER("Document No.", Rec."No.");

        //To ensure that at least a line is selected to be converted into an order
        IF NOT PurchaseReqLine.FIND('-') THEN
            ERROR('Select the lines you want to convert into an Quote.')
        ELSE
            ;

        i := 0;    //to capture the first number
        PrevVendorNo := '';
        CLEAR(DocNo);
        IF PurchaseReqLine.FINDFIRST THEN BEGIN
            REPEAT
                PurchaseReqLine.TestField("Transfer to Job Jnl", false);
                PurchaseReqLine.TESTFIELD(PurchaseReqLine."Buy-from Vendor No.");
                IF PurchaseReqLine."Buy-from Vendor No." <> PrevVendorNo THEN   //create new header
                  BEGIN
                    Vend.GET(PurchaseReqLine."Buy-from Vendor No.");
                    Vend.CheckBlockedVendOnDocs(Vend, FALSE);
                    PurchaseOrderHdr.INIT;
                    NextDocNo := NoSeriesMgt.GetNextNo(PurchSetup."Quote Nos.", TODAY, TRUE);
                    PurchaseOrderHdr."No." := NextDocNo;

                    PurchaseOrderHdr."Document Type" := PurchaseOrderHdr."Document Type"::Quote;
                    PurchaseOrderHdr."Buy-from Vendor No." := PurchaseReqLine."Buy-from Vendor No.";
                    PurchaseOrderHdr."No. Printed" := 0;
                    PurchaseOrderHdr."Store Requisition No." := Rec."Store Requisition No.";
                    PurchaseOrderHdr."Purchase Requisition No." := Rec."No.";
                    PurchaseOrderHdr.Status := PurchaseOrderHdr.Status::Open;
                    PurchaseOrderHdr."Order Date" := Rec."Order Date";

                    PurchaseOrderHdr.InitRecord;
                    PurchOrderNo := PurchaseOrderHdr."No.";
                    PurchaseOrderHdr.VALIDATE("Posting Description", Rec."Posting Description");
                    PurchaseOrderHdr."Equipment No." := Rec."Equipment No.";
                    PurchaseOrderHdr."Equipment Type" := Rec."Equipment Type";
                    PurchaseOrderHdr."Responsible Employee" := Rec."Responsible Employee";
                    PurchaseOrderHdr."Dimension Set ID" := Rec."Dimension Set ID";

                    IF Rec."Posting Date" <> 0D THEN
                        PurchaseOrderHdr."Posting Date" := Rec."Posting Date";
                    PurchaseOrderHdr."Document Date" := Rec."Document Date";
                    PurchaseOrderHdr."Purchase Requisition No." := Rec."No.";
                    PurchaseOrderHdr."Expected Receipt Date" := Rec."Expected Receipt Date";
                    PurchaseOrderHdr."Currency Code" := Rec."Currency Code";


                    PurchaseOrderHdr.INSERT(TRUE);
                    //  Transfer dimension to the purchase header.
                    PurchaseOrderHdr.VALIDATE(PurchaseOrderHdr."Buy-from Vendor No.");
                    PurchaseOrderHdr.VALIDATE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    PurchaseOrderHdr.VALIDATE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                    PurchaseOrderHdr.VALIDATE("Dimension Set ID", Rec."Dimension Set ID");
                    PurchaseOrderHdr.VALIDATE("Currency Code", Rec."Currency Code");
                    PurchaseOrderHdr."Posting Description" := Rec."Posting Description";
                    //END.

                    PurchaseOrderHdr.MODIFY;
                    LineNo := 0;
                    i += 1;
                    DocNo[i] := PurchaseOrderHdr."No.";

                    //Insert the Line Item Line
                    PurchaseOrderLine2.RESET;
                    PurchaseOrderLine2.SETFILTER("Document Type", FORMAT(PurchaseOrderLine2."Document Type"::"Purchase Requisition"));
                    PurchaseOrderLine2.SETFILTER("Buy-from Vendor No.", PurchaseReqLine."Buy-from Vendor No.");
                    PurchaseOrderLine2.SETFILTER(PurchaseOrderLine2."Document No.", Rec."No.");
                    PurchaseOrderLine2.SETRANGE(Convert, TRUE);
                    PurchaseOrderLine2.SETRANGE(Converted, FALSE);
                    IF PurchaseOrderLine2.FINDSET THEN
                        REPEAT
                            LineNo += 10000;
                            PurchaseOrderLine.LOCKTABLE;
                            PurchaseOrderLine.INIT;

                            PurchaseOrderLine."Document Type" := PurchaseOrderLine."Document Type"::Quote;
                            PurchaseOrderLine."Document No." := NextDocNo;
                            PurchaseOrderLine."Line No." := LineNo;
                            PurchaseOrderLine.VALIDATE("Buy-from Vendor No.", PurchaseOrderLine2."Buy-from Vendor No.");
                            PurchaseOrderLine.Type := PurchaseOrderLine2.Type;
                            PurchaseOrderLine.VALIDATE("No.", PurchaseOrderLine2."No.");
                            PurchaseOrderLine.Description := PurchaseOrderLine2.Description;
                            PurchaseOrderLine."Location Code" := PurchaseOrderLine2."Location Code";
                            PurchaseOrderLine.VALIDATE("Currency Code", PurchaseOrderLine2."Currency Code");
                            PurchaseOrderLine.VALIDATE("Dimension Set ID", PurchaseOrderLine2."Dimension Set ID");
                            PurchaseOrderLine.VALIDATE(Quantity, PurchaseOrderLine2.Quantity);
                            PurchaseOrderLine."Unit of Measure" := PurchaseOrderLine2."Unit of Measure";
                            PurchaseOrderLine.validate("Direct Unit Cost", PurchaseOrderLine2."Direct Unit Cost");
                            PurchaseOrderLine."Unit Cost (LCY)" := PurchaseOrderLine2."Unit Cost (LCY)";
                            PurchaseOrderLine.validate("VAT Prod. Posting Group", PurchaseOrderLine2."VAT Prod. Posting Group");
                            PurchaseOrderLine.validate("VAT Bus. Posting Group", PurchaseOrderLine2."VAT Bus. Posting Group");

                            PurchaseOrderHdr.VALIDATE("No.", Rec."No.");
                            PurchaseOrderLine.VALIDATE(Quantity, PurchaseOrderLine2."Qty. to Order");
                            partialOrder := TRUE;
                            PurchaseOrderLine."Control Account" := PurchaseOrderLine2."Control Account";
                            PurchaseOrderLine."Commitment Entry No." := PurchaseOrderLine2."Commitment Entry No.";
                            PurchaseOrderLine."Commitment Budget" := PurchaseOrderLine2."Budget Code";
                            PurchaseOrderLine."Deferral Code" := PurchaseOrderLine2."Deferral Code";
                            PurchaseOrderLine."Equipment No." := PurchaseOrderLine2."Equipment No.";
                            PurchaseOrderLine."Equipment Type" := PurchaseOrderLine2."Equipment Type";
                            PurchaseOrderLine."Responsible Employee" := Rec."Responsible Employee";

                            PurchaseOrderLine.INSERT(TRUE);
                            PurchaseOrderLine."Gen. Bus. Posting Group" := PurchaseOrderHdr."Gen. Bus. Posting Group";
                            PurchaseOrderLine.MODIFY;


                            PurchaseOrderLine2.Converted := TRUE;
                            PurchaseOrderLine2.MODIFY;

                        UNTIL PurchaseOrderLine2.NEXT = 0;

                    lvPurchaseHeader.GET(lvPurchaseHeader."Document Type"::Quote, PurchOrderNo);
                    lvPurchaseHeader.Status := Rec.Status::Released;
                    lvPurchaseHeader.MODIFY;
                    Rec."Dimension Set ID" := PurchaseReqLine."Dimension Set ID";


                    PrevVendorNo := PurchaseReqLine."Buy-from Vendor No.";
                END;
            UNTIL PurchaseReqLine.NEXT = 0;
        END;

        ANFSetup.GET;

        COMMIT;

        //Confirmation message
        IF i = 1 THEN BEGIN
            MESSAGE(Text004,
                Rec."No.", DocNo[1]);
            Rec."Converted to Quote" := TRUE;
            Rec.Archived := true;
            Rec.MODIFY;
        END ELSE BEGIN
            MESSAGE(Text005,
                Rec."No.", DocNo[1], DocNo[i]);
            Rec."Converted to Quote" := TRUE;
            Rec.MODIFY;
        END;

        //Open the quote page

    end;

    /// <summary>
    /// Description for EditFields.
    /// </summary>
    local procedure EditFields();
    var
        ReqnHeaderr: Record "ADT Requisition Header";
    begin
        ReqnHeaderr.RESET;
        ReqnHeaderr.SETRANGE("No.", Rec."No.");
        ReqnHeaderr.SETRANGE(Status, Rec.Status::Released);
        ReqnHeaderr.SETRANGE("Document Type", Rec."Document Type"::"Purchase Requisition");
        IF ReqnHeaderr.FINDFIRST THEN
            Edit := TRUE
        ELSE
            Edit := FALSE;
    end;
}

