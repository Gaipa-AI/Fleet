page 50049 "External Hire Request"
{
    Caption = 'External Hire Request';
    SourceTable = "Form Header";
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTableView = WHERE("Document Type" = FILTER("External Hire"), "Client Category" = const(EXTERNAL));

    layout
    {
        area(Content)
        {
            group(ClientDetails)
            {
                Caption = 'Client Details';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    Editable = PreviewMode;
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client No. field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client Name field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address 2 field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Job Location"; Rec."Job Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Location field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Job Start Date"; Rec."Job Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Start Date field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Job End Date"; Rec."Job End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job End Date field.', Comment = '%';
                    Editable = PreviewMode;
                }
                 field("Hire days"; Rec."Hire Days")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;

                }
                field("Client Category"; Rec."Client Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client Category field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Contact Person Name"; Rec."Contact Person Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Person Name field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Contact Person Contact"; Rec."Contact Person Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Person Contact field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Contact Person Email"; Rec."Contact Person Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Person Email field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

            }
            part(ExternalHireLines; "External Hire Request Subform")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Editable = PreviewMode;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(Employees; "External Hire Employee Type")
            {
                Caption = 'Employees';
                ApplicationArea = All;
                // Editable = PreviewMode;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            group(TermsOfHire)
            {
                Caption = 'Terms Of Hire';
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hourly Rate field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field(Daily; Rec.Daily)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Daily field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field(Monthly; Rec.Monthly)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Monthly field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Dry Hire"; Rec."Dry Hire")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dry Hire field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Wet Hire"; Rec."Wet Hire")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Wet Hire field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Per Trip"; Rec."Per Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Per Trip field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field(Other; Rec.Other)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other field.', Comment = '%';
                    Editable = PreviewMode;
                }
            }
            group(OfficialUse)
            {
                Caption = 'Official';
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Hire Rate"; Rec."Hire Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hire Rate field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Terms field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Approvals Entry"; Rec."Approvals Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approvals Entry field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Approver field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Set out"; Rec."Set out")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Started';
                    ToolTip = 'Specifies the value of the Set out field.', Comment = '%';
                }
                field("Set out By"; Rec."Set out By")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Started By.';
                    ToolTip = 'Specifies the value of the Set out By field.', Comment = '%';
                }
                field("Set Out Date"; Rec."Set Out Date")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Start Date';
                    ToolTip = 'Specifies the value of the Set Out Date field.', Comment = '%';
                }
                field("Touch Down"; Rec."Touch Down")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Ended';
                    ToolTip = 'Specifies the value of the Touch Down field.', Comment = '%';
                }
                field("Touch Down By"; Rec."Touch Down By")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Ended By';
                    ToolTip = 'Specifies the value of the Touch Down By field.', Comment = '%';
                }
                field("Touch Down Date"; Rec."Touch Down Date")
                {
                    ApplicationArea = All;
                    Caption = 'Journey Ended Date';
                    ToolTip = 'Specifies the value of the Touch Down Date field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                    Editable = false;
                }
            }

            group(Invoicing)
            {
                field("Line To Invoice Type"; Rec."Line To Invoice Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line To Invoice Type field.', Comment = '%';
                    Editable = ConvertedValue;
                }
                field("Line To Invoice No."; Rec."Line To Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line To Invoice No. field.', Comment = '%';
                    Editable = ConvertedValue;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                    Editable = ConvertedValue;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                    Editable = ConvertedValue;
                }
                field(Converted; Rec.Converted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Converted field.', Comment = '%';
                }
                field("Sales Invoice/Order No."; Rec."Sales Invoice/Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Invoice/Order No. field.', Comment = '%';
                    Editable = false;
                }
                field("Terms of Hire"; Rec.TermsofHire)
                {
                    ApplicationArea = All;
                    Tooltip = 'Selected terms of hire';
                    Editable = false;
                    

                }
                field("Estimated Cost"; Rec.EstimatedHireCost)
                {
                    ApplicationArea = All;
                    Tooltip = 'Cost of hire';
                   
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
        area(Processing)
        {
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
                    RequisitionHeader: Record "Form Header";
                    RptPurchaseRequisition: Report "Hire Request";
                begin
                    RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"External Hire");
                    RequisitionHeader.SETRANGE("No.", Rec."No.");
                    RptPurchaseRequisition.SETTABLEVIEW(RequisitionHeader);
                    RptPurchaseRequisition.RUNMODAL;
                end;
            }
            action(CreateSalesInvoice)
            {
                ApplicationArea = All;
                Caption = 'Create Sales Invoice';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    DocumentType: Enum "Sales Document Type";
                begin
                    Rec.TestField(Converted, false);
                    Rec.TestField(Status, Rec.Status::Released);
                    if Confirm('Are you sure you want to create a sales Invoice', true) then
                        Rec.CreateSalesInvoice(DocumentType::Invoice);
                end;
            }
            action(CreateSalesOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Sales Order';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    DocumentType: Enum "Sales Document Type";
                begin
                    Rec.TestField(Converted, false);
                    Rec.TestField(Status, Rec.Status::Released);
                    if Confirm('Are you sure you want to create a sales Order', true) then
                        Rec.CreateSalesInvoice(DocumentType::Order);
                end;
            }
            action(StartJourney)
            {
                ApplicationArea = All;
                Caption = 'Start Journey';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField(Authorized, true);
                    if Confirm('Are you sure you want to start this Journey?', true) then
                        Rec.SetOut();
                    CurrPage.Update();
                end;
            }
            action(EndJourney)
            {
                ApplicationArea = All;
                Caption = 'End Journey';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.TestField(Authorized, true);
                    if Confirm('Are you sure you want to End this Journey?', true) then
                        Rec.touchDown();
                    CurrPage.Update();
                end;
            }
            action(CalculateCost)
            {
                ApplicationArea = All;
                Caption = 'Calculate Cost';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec."Line To Invoice Type" := Rec."Line To Invoice Type"::"G/L Account";
                    Rec."Line To Invoice No." := '15110';
                    Rec."Unit of Measure Code" := 'EACH';
                    Rec."Posting Date" := Today();
                   GetTermsOfHireText();
                   Rec.EstimatedHireCost := CalculateEstimatedCost();
                   Rec.Modify();
                end;
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
                        CurrPage.Update();
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField(Date);
                        Rec.TestField("Client Name");
                        Rec.TestField("Equipment Type");
                        Rec.TestField(Quantity);
                        Rec.TestField("Job Location");
                        Rec.TestField("Job Start Date");
                        rec.TestField("Job End Date");
                        Rec.TestField("Hire Rate");
                        Rec.TestField("Payment Terms");

                        CheckForEquipmentLines();

                        if ((Rec."Hourly Rate" = false) AND
                        (Rec.Daily = false) AND
                        (Rec.Monthly = false) AND
                        (Rec."Dry Hire" = false) AND
                        (Rec."Wet Hire" = false) AND
                        (Rec."Per Trip" = false) AND
                        (Rec.Other = '')) then
                            Error('Select an option under Terms of Hire');

                        IF Rec."Prepared by" <> USERID THEN
                            ERROR('The selected request can only be sent for approval by the initiator %1', Rec."Prepared by");

                        if Confirm('Are you sure you want to send this Approval Request?', true) then begin
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
                    RunPageLink = "Document Type" = filter("External Hire"),
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
                        if Confirm('Are you sure you want to cancel this request?', true) then begin
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
                        Rec.TestField(Status, Rec.Status::Released);

                        if Confirm('Are sure You Want to Open This Document ?', true) then begin
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
                        Txt001: Label 'Are you sure you want to Approve this document?';
                        Txt002: Label 'Please make Sure you have at least one line in the Requisition Lines';
                        UserSetup: Record "User Setup";
                        ApprovalDoc: Codeunit "Fleet Management";
                    begin
                        if Rec.Status = Rec.Status::Released then
                            Error('This document is already released');
                        if Rec.Status = Rec.Status::Open then
                            Error('Document Status must be set to Pending Approval');

                        if Confirm(Txt001, true) then begin
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
                            customFunction.OpenApprovalEntriesFM(Rec);
                            Rec.CheckDocumentRelease(Rec);
                            Rec.SendRequisitionApprovedEmail(Rec);
                        end;
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

                        if Confirm('Are you sure you want to Reject this Document?', true) then begin
                            //Checking for comments before rejecting
                            ApprovalComments.Reset();
                            ApprovalComments.SetRange(ApprovalComments."No.", Rec."No.");
                            ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"External Hire");
                            if ApprovalComments.FindFirst() then begin
                                ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                                Rec.Status := Rec.Status::Rejected;
                                customFunction.RejectApprovalRequestFM(Rec);
                                Rec.SendRejectEmail(Rec);
                            end else begin
                                ApprovalComments2.Reset();
                                ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"External Hire");
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

                        Rec.TestField(Status, Rec.Status::"Pending Approval");

                        if Confirm(Txt002, true) then begin
                            CustomPurchFunction.DelegatePurchaseApprovalRequestFM(Rec);
                            Rec.SendRequisitionApprovedEmail(Rec);
                        end;
                    end;
                }
            }
        }

        area(Navigation)
        {
            group(Request)
            {
                action("Comments")
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("External Hire"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(salesInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoices';
                    Image = List;
                    RunObject = page "Sales Invoice List";
                    RunPageLink = "Equipment Hire No." = field("No.");
                }
                action(salesOrders)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders';
                    Image = List;
                    RunObject = page "Sales Order List";
                    RunPageLink = "Equipment Hire No." = field("No.");
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    Image = List;
                    RunObject = page "Posted Sales Invoices";
                    RunPageLink = "Equipment Hire No." = field("No.");
                }
                action(PostedSalesCreditMemo)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales CreditMemo';
                    Image = List;
                    RunObject = page "Posted Sales Credit Memos";
                    RunPageLink = "Equipment Hire No." = field("No.");
                }
                action(DocAttach)
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
    }

    trigger OnAfterGetRecord()
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        Rec."Client Category" := Rec."Client Category"::EXTERNAL;

        PreviewMode := true;
        ConvertedValue := true;
        Rec."Document Type" := Rec."Document Type"::"External Hire";
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
        if Rec.Converted then
            ConvertedValue := false;
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
        ConvertedValue: Boolean;

    procedure CheckForEquipmentLines()
    var
        FormLines: Record "Form Line";
    begin
        FormLines.Reset();
        FormLines.SetRange("Document Type", Rec."Document Type");
        FormLines.SetRange("Document No.", Rec."No.");
        if not FormLines.FindFirst() then
            Error('Please select the item(s) to be hired out.');
    end;

    local procedure GetTermsOfHireText(): Text[100]
    
    begin
        if Rec."Hourly Rate" = not false then
            Rec.TermsOfHire := 'Hourly'
        else
        if Rec.Monthly = not false then
            Rec.TermsOfHire := 'Monthly'
        else
        if Rec."Per Trip" = not false then
            Rec.TermsOfHire := 'Per Trip'
        else
        if Rec."Dry Hire" = not false then
            Rec.TermsOfHire := 'Dry Hire'
        else
        if Rec."Wet Hire" = not false then
            Rec.TermsOfHire := 'Wet Hire'
        else
        if Rec."Daily" = not false then
            Rec.TermsOfHire := 'Daily'
        else
        if Rec.Other <> '' then
            Rec.TermsOfHire := 'Other: ' + Rec.Other
        else
            Rec.TermsOfHire := '';

        Rec.Modify();

    end;

    local procedure CalculateEstimatedCost(): Decimal
    begin
        if Rec.Quantity = 0 then
            exit(0);

        exit(Rec.Quantity * Rec."Hire Rate" * GetHireDurationFactor());
    end;

local procedure GetHireDurationFactor(): Decimal
begin
    if Rec."Per Trip" then
        exit(Rec."Hire Days" * 2);

    if Rec."Hourly Rate" then
        exit(Rec."Hire Days" * 24);

    // if Rec.Weekly then
    //     exit(Rec."Hire Days" / 7);

    if Rec.Monthly then
        exit(Rec."Hire Days" / 30);

    // Daily / Dry Hire / Wet Hire are charged per day
    if Rec."Daily" or Rec."Dry Hire" or Rec."Wet Hire" then
        exit(Rec."Hire Days");

    // fallback
    exit(Rec."Hire Days");
  end;
}