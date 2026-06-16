page 50040 "General Requisition"
{

    Caption = 'General Requisition';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTable = "ADT Requisition Header";
    SourceTableView = WHERE("Document Type" = FILTER("Purchase Requisition"), "Request Type" = filter(General));
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
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    Caption = 'Request Reason';
                    // Editable = EditPage;
                    MultiLine = true;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    // Editable = EditPage;
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
                }
                field("Converted to Quote"; Rec."Converted to Quote")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Approvals Entry"; Rec."Approvals Entry")
                {
                    ApplicationArea = All;
                }
                field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                }
                field(Archived; Rec.Archived)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Authorize Requisition"; Rec."Authorize Requisition")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authorize Requisition field.', Comment = '%';
                }
                field("Authorized by"; Rec."Authorized by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authorized by field.', Comment = '%';
                }
                field("Authorized Date"; Rec."Authorized Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Authorized Date field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                }
                field("Requisition Lines Total"; Rec."Requisition Lines Total")
                {
                    ApplicationArea = All;
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
            part(PurchLines; "General Requisition Subform")
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
                    Caption = 'Cross Referencing';
                    action("Purchase Orders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Orders';
                        RunObject = Page "Purchase List";
                        RunPageLink = "Purchase Requisition No." = FIELD("No.");
                        RunPageView = SORTING("Document Type", "No.")
                                      WHERE("Document Type" = CONST(Order));
                    }
                    action("Posted Purchase Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Invoices';
                        RunObject = Page "Posted Purchase Invoices";
                        RunPageLink = "Purchase Requisition No." = FIELD("No.");
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                separator(separator1)
                {
                }
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
                separator(separator2)
                {
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
                separator(".......")
                {
                }
                separator(".....")
                {
                }
                action("Release Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Release Requisition';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ReleaseDoc;


                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to release this document?', true) then
                            ReleaseRequisition();
                    end;
                }
                action("Authorize Request")
                {
                    ApplicationArea = All;
                    Caption = 'Authorize Requisition';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = AuthorizeCreditCard;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to authorize this document?', true) then
                            AuthorizeRequisition();
                    end;
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
                        Rec.TestField("Authorize Requisition", true);
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
                                ERROR('This Purchase Requisition Has been fully converted into an Quotes(s)');
                        END;
                        MakePurchaseQuote();
                    end;
                }
                action("Consume from Stock")
                {
                    Caption = 'Consume from Stock';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    Image = TransferToGeneralJournal;
                    trigger OnAction();
                    var
                        BankReconn: Record "Bank Acc. Reconciliation";
                        PaymentJnl: Record "Gen. Journal Line";
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField("Authorize Requisition", true);
                        Rec.TESTFIELD("No.");
                        Rec.TESTFIELD("Request-By No.");
                        IF CONFIRM('Are you sure you want to transfer these lines to Item journal?') THEN BEGIN
                            if Rec."Request Type" = Rec."Request Type"::Fuel then begin
                                ANFSetup.GET;
                                ANFSetup.TESTFIELD("Fuel Req Item Jnl Template");
                                ANFSetup.TESTFIELD("Fuel Req Item Jnl Batch");
                                TransferSpareToItemJnl(ANFSetup."Fuel Req Item Jnl Template", ANFSetup."Fuel Req Item Jnl Batch");
                                Rec.ArchiveStoreRequisition();
                            end else if Rec."Request Type" = Rec."Request Type"::General then begin
                                ANFSetup.GET;
                                ANFSetup.TESTFIELD("Gen Req Item Jnl Template");
                                ANFSetup.TESTFIELD("Gen Req Item Jnl Batch");
                                TransferSpareToItemJnl(ANFSetup."Gen Req Item Jnl Template", ANFSetup."Gen Req Item Jnl Batch");
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
                        ReqnHeader: Record "ADT Requisition Header";
                        RptPurchaseReqn: Report "Purchase Requisition";
                    begin
                        ReqnHeader.SETRANGE("Document Type", ReqnHeader."Document Type"::"Purchase Requisition");
                        ReqnHeader.SETRANGE("No.", Rec."No.");
                        RptPurchaseReqn.SETTABLEVIEW(ReqnHeader);
                        RptPurchaseReqn.RUNMODAL;
                    end;
                }
                action("Detail Commitment Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Detail Commitment Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
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
                        ReqnHeader: Record "ADT Requisition Header";
                        RptPurchaseReqn: Report "Purchase Requisition";
                    begin
                        ReqnHeader.SETRANGE("Document Type", ReqnHeader."Document Type"::"Purchase Requisition");
                        ReqnHeader.SETRANGE("No.", Rec."No.");
                        ReptForm5.SETTABLEVIEW(ReqnHeader);
                        ReptForm5.RUNMODAL;
                        CLEAR(ReptForm5);
                    end;
                }
            }

            // group("Request Approval")
            // {
            //     Caption = 'Request Approval';
            //     action("Send A&pproval Request")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Send A&pproval Request';
            //         Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
            //         Image = SendApprovalRequest;
            //         Promoted = true;
            //         PromotedCategory = Category6;  // 'Request Approval' category from PromotedActionCategories
            //         PromotedIsBig = true;
            //         ToolTip = 'Request approval of the document.';
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             // Add any custom validation here if needed, e.g., check fields like in Maintenance Request
            //             Rec.TESTFIELD("Request-By No.");
            //             Rec.TESTFIELD("Posting Date");
            //             // ... other validations ...

            //             if Confirm('Are you sure you want to send this Approval Request?', true) then begin
            //                 //ApprovalsMgmt.OnSendADTRequisitionHeaderForApproval(Rec);  // Adjust codeunit/method as per your setup
            //                 //ApprovalsMgmt.OnSendSalesDocForApproval(Rec); // Example method, replace with actual
            //                 CurrPage.Update();
            //             end;
            //         end;
            //     }

            //     action("Cancel Approval Re&quest")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Cancel Approval Re&quest';
            //         Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
            //         Image = CancelApprovalRequest;
            //         Promoted = true;
            //         PromotedCategory = Category6;
            //         ToolTip = 'Cancel the approval request.';
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //             WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
            //         begin
            //             //ApprovalsMgmt.OnCancelADTRequisitionHeaderApprovalRequest(Rec);  // Adjust as needed
            //             WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
            //             CurrPage.Update();
            //         end;
            //     }

            //     action(ReOpen)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'ReOpen';
            //         Promoted = true;
            //         PromotedCategory = Category6;
            //         PromotedIsBig = true;
            //         ToolTip = 'Reopens the Requisition Document';
            //         Image = ReOpen;
            //         trigger OnAction()
            //         var
            //             RequisitionHeader: Record "ADT Requisition Header";
            //         begin
            //             // Add logic to reset status, e.g., Rec.Status := Rec.Status::Open; Rec.Modify();
            //             CurrPage.Update();
            //         end;
            //     }
            // }

            // group(ApprovalApprove)
            // {
            //     Caption = 'Approve';
            //     action(Approve)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Approve';
            //         Image = Approve;
            //         Promoted = true;
            //         PromotedCategory = Category5;  // 'Approve' category
            //         PromotedIsBig = true;
            //         PromotedOnly = true;
            //         ToolTip = 'Approve the requested changes.';
            //         Visible = OpenApprovalEntriesExistForCurrUser;
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
            //             CurrPage.Update();
            //         end;
            //     }

            //     action(Reject)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Reject';
            //         Image = Reject;
            //         Promoted = true;
            //         PromotedCategory = Category5;
            //         PromotedIsBig = true;
            //         PromotedOnly = true;
            //         ToolTip = 'Reject the approval request.';
            //         Visible = OpenApprovalEntriesExistForCurrUser;
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
            //             CurrPage.Update();
            //         end;
            //     }

            //     action(Delegate)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Delegate';
            //         Image = Delegate;
            //         Promoted = true;
            //         PromotedCategory = Category9;  // 'Delegate' category
            //         PromotedOnly = true;
            //         ToolTip = 'Delegate the approval to a substitute approver.';
            //         Visible = OpenApprovalEntriesExistForCurrUser;
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approvals Mgmt.";
            //         begin
            //             ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
            //             CurrPage.Update();
            //         end;
            //     }
            // }
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
        //NoSeriesMgt: Codeunit "NoSeriesManagement";
        NoSeriesMgt: Codeunit "No. Series";
        i: Integer;
        DocNo: array[30] of Code[20];
        Text002: Label 'Requsition number %1 has been converted to Quote Numbers %2 - %3';
        PurchaseReqLine: Record "ADT Requisition Line";
        Text003: Label 'Do you want to convert the Requisition to an Order?';
        Text004: Label 'Requisition number %1 has been converted to Order number %2.';
        Text005: Label 'Requsition number %1 has been converted to Orders Number %2 - %3';
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
        IF StoreReqLine.FINDFIRST THEN BEGIN
            REPEAT
                StoreReqLine.TestField("Transferred to Job Jnl", false);
                StoreReqLine.TestField("Posting Date");
                //Check the inventory to see wether there is stock
                OneStoreReqLine.GET(StoreReqLine."Document Type", StoreReqLine."Request Type", StoreReqLine."Document No.", StoreReqLine."Line No.");
                InvtQty := NFLInfoPaneMgt.CalcAvailability2(OneStoreReqLine);
                IF StoreReqLine."Qty To Transfer to Item Jnl" > InvtQty THEN
                    ERROR('Item No %1 in Line No %2 has no sufficient stock in Inventory:Inventory has %3', StoreReqLine."No.",
                    StoreReqLine."Line No.", InvtQty);

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

            Message('Items successfully transferred to the item journal: %1', JournalBatch);
        END ELSE
            ERROR('There are no lines to Consume from Stock.');
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
        "====AMI====": Integer;
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
            Rec.Archived := true;
            Rec.MODIFY;
        END;
        // Achieve the requisition after converting it to a quote.
        //To Archive only if all lines have been converted into quotes
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

    procedure AuthorizeRequisition()
    var
        RequisitionHeader: Record "ADT Requisition Header";
        UserSetup: Record "User Setup";
    begin
        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField(Transferred, false);
        Rec.TestField("Converted to Quote", false);
        Rec.TestField("Posting Date");
        Rec.TestField("Posting Description");
        Rec.TestField("Location Code");
        Rec.TestField("Request-By No.");
        Rec.TestField("Request-By Name");
        Rec.TestField("Request Type", Rec."Request Type"::General);

        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Can Authorize Requisition" then begin
                RequisitionHeader.Reset();
                RequisitionHeader.SetRange("No.", Rec."No.");
                RequisitionHeader.SetRange("Request Type", RequisitionHeader."Request Type"::General);
                if RequisitionHeader.FindFirst() then begin
                    RequisitionHeader."Authorize Requisition" := true;
                    RequisitionHeader."Authorized Date" := Today;
                    RequisitionHeader."Authorized by" := UserId;
                    RequisitionHeader.Modify();
                    Message('Document Authorized Successfully.');
                end;
            end else
                Error('You are not allowed to authorize this document.');
        end else
            Error('You are not in the user Setup');
    end;

    procedure ReleaseRequisition()
    var
        RequisitionHeader: Record "ADT Requisition Header";
        UserSetup: Record "User Setup";
    begin
        Rec.TestField(Status, Rec.Status::Open);
        Rec.TestField(Transferred, false);
        Rec.TestField("Converted to Quote", false);
        Rec.TestField("Posting Date");
        Rec.TestField("Posting Description");
        Rec.TestField("Location Code");
        Rec.TestField("Request-By Name");
        Rec.TestField("Authorize Requisition", true);
        Rec.TestField("Request Type", Rec."Request Type"::General);

        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Can Release Requisition" then begin
                RequisitionHeader.Reset();
                RequisitionHeader.SetRange("No.", Rec."No.");
                RequisitionHeader.SetRange("Request Type", RequisitionHeader."Request Type"::General);
                if RequisitionHeader.FindFirst() then begin
                    RequisitionHeader.Status := RequisitionHeader.Status::Released;
                    RequisitionHeader."Release date" := Today;
                    RequisitionHeader."Released By" := UserId;
                    RequisitionHeader.Modify();
                    Message('Document Released Successfully.');
                end;
            end else
                Error('You are not allowed to release this document.');
        end else
            Error('You are not in the user Setup');
    end;
}

