page 50033 "Equipment HandOver Form"
{
    Caption = 'Equipment HandOver Form';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTable = "Form Header";
    DataCaptionFields = "No.", "Equipment No.", "Equipment Name";
    SourceTableView = WHERE("Document Type" = FILTER("Equipment Hand Over"));

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field(Time; Time)
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field("Former Driver"; Rec."Former Driver")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Former Driver field.', Comment = '%';
                    Editable = PreviewMode;
                }
                field("Former Driver Name"; Rec."Former Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Former Driver Name field.', Comment = '%';
                    Editable = false;
                }
                field("Assigned Driver"; Rec."Assigned Driver")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Assigned Driver field.', Comment = '%';
                }
                field("Assigned Driver Name"; Rec."Assigned Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assigned Driver Name field.', Comment = '%';
                    Editable = false;
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                    //DrillDownPageID = "Equipment Driver List" ;
                    //RunObjectPageView = 
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
                    trigger OnValidate()
                    begin
                        if Rec."Document Type" = Rec."Document Type"::"Equipment Hand Over" then
                            Rec.CreateFormLines();
                    end;

                }
                field("Equipment Make"; Rec."Equipment Make")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Equipment Make field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                }
                field("Equipment Model"; Rec."Equipment Model")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Model field.', Comment = '%';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field("Equipment Serial No."; Rec."Equipment Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Serial No. field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    //Editable = PreviewMode;
                    Editable = false;

                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                }
                // field("Approvals Entry"; Rec."Approvals Entry")
                // {
                //     ApplicationArea = All;
                //     Editable = PreviewMode;
                //     ToolTip = 'Specifies the value of the Approvals Entry field.', Comment = '%';
                // }
                field("Current Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    ToolTip = 'Specifies the value of the Current Approver field.', Comment = '%';
                }
                field("Driver Assigned"; Rec."Driver Assigned")
                {
                    ApplicationArea = All;
                    //Editable = PreviewMode;
                    Editable = false;
                }
                field("Assignment Date"; Rec."Assignment Date")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }

            }

            group(Condition)
            {
                field("Any Dents"; Rec."Any Dents")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field("Dents Description"; Rec."Dents Description")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    MultiLine = true;
                }
                field("Any Scratches"; Rec."Any Scratches")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field("Scratches Description"; Rec."Scratches Description")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    MultiLine = true;
                }
                field("Interior Condition"; Rec."Interior Condition")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field("Interior Remarks"; Rec."Interior Remarks")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    MultiLine = true;
                }
                field("General Mechanical Condition"; Rec."General Mechanical Condition")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field("Mechanical Remarks"; Rec."Mechanical Remarks")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                    MultiLine = true;
                }

            }
            group(Service)
            {
                field("Fuel Level"; Rec."Fuel Level")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field("Odometer Reading"; Rec."Odometer Reading")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field("Next Service"; Rec."Next Service")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
            }
            part(Items; "Equipment HandOver Subform")
            {
                Caption = 'Items';
                Editable = PreviewMode;
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Driver)
            {
                field("Driver's License"; Rec."Driver's License")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field("Defensive Driving Certificate"; Rec."Defensive Driving Certificate")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
                }
                field("Medical Fitness Certificate"; Rec."Medical Fitness Certificate")
                {
                    ApplicationArea = All;
                    Editable = PreviewMode;
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
                Caption = 'Hand Over';

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Equipment Hand Over"),
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
                        MaintenanceReport: Report "Vehicle Hand Over";
                    begin
                        RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Equipment Hand Over");
                        RequisitionHeader.SETRANGE("No.", Rec."No.");
                        MaintenanceReport.SETTABLEVIEW(RequisitionHeader);
                        MaintenanceReport.RUNMODAL;
                    end;
                }
                action(AssignDriver)
                {
                    ApplicationArea = All;
                    Caption = 'Assign Driver';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = FixedAssets;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField("Driver Assigned", false);
                        if Confirm('Are you sure you want to assign this Equipment', true) then
                            Rec.AssignDriver();
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
                        CurrPage.Update();

                        Rec.TESTFIELD("Equipment No.");
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField(Date);
                        Rec.TestField("Former Driver");
                        Rec.TestField("Assigned Driver");
                        //Rec.TestField("Any Dents");
                       // Rec.TestField("Dents Description");
                        //Rec.TestField("Interior Condition");
                        //Rec.TestField("Interior Remarks");
                        //Rec.TestField("Any Scratches");
                        //Rec.TestField("Scratches Description");
                        Rec.TestField("General Mechanical Condition");
                        Rec.TestField("Mechanical Remarks");
                        Rec.TestField("Fuel Level");
                        Rec.TestField("Odometer Reading");
                        Rec.TestField("Next Service");
                        Rec.TestField("Driver's License");
                        Rec.TestField("Defensive Driving Certificate");
                        Rec.TestField("Medical Fitness Certificate");

                        // Check if there is at least one Form Request Lines
                        FormLine.Reset();
                        FormLine.SetRange("Document No.", Rec."No.");
                        if not FormLine.FindFirst() then
                            ERROR(Text0022);

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

                        Rec.TESTFIELD("Equipment No.");
                        Rec.TestField(Date);
                        Rec.TestField("Former Driver");
                        Rec.TestField("Assigned Driver");
                        //Rec.TestField("Any Dents");
                        //Rec.TestField("Dents Description");
                        // Rec.TestField("Interior Condition");
                        // Rec.TestField("Interior Remarks");
                        //Rec.TestField("Any Scratches");
                        // Rec.TestField("Scratches Description");
                        // Rec.TestField("General Mechanical Condition");
                        Rec.TestField("Mechanical Remarks");
                        Rec.TestField("Fuel Level");
                        Rec.TestField("Odometer Reading");
                        Rec.TestField("Next Service");
                        Rec.TestField("Driver's License");
                        Rec.TestField("Defensive Driving Certificate");
                        Rec.TestField("Medical Fitness Certificate");
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

                        Rec.TESTFIELD("Equipment No.");
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.TestField(Date);
                        Rec.TestField("Former Driver");
                        Rec.TestField("Assigned Driver");
                        // Rec.TestField("Any Dents");
                        // Rec.TestField("Dents Description");
                        // Rec.TestField("Interior Condition");
                        // Rec.TestField("Interior Remarks");
                        // Rec.TestField("Any Scratches");
                        // Rec.TestField("Scratches Description");
                        Rec.TestField("General Mechanical Condition");
                        Rec.TestField("Mechanical Remarks");
                        Rec.TestField("Fuel Level");
                        Rec.TestField("Odometer Reading");
                        Rec.TestField("Next Service");
                        Rec.TestField("Driver's License");
                        Rec.TestField("Defensive Driving Certificate");
                        Rec.TestField("Medical Fitness Certificate");
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
                        Rec.TESTFIELD("Equipment No.");
                        Rec.TestField(Date);
                        Rec.TestField("Former Driver");
                        Rec.TestField("Assigned Driver");
                        // Rec.TestField("Any Dents");
                        // Rec.TestField("Dents Description");
                        // Rec.TestField("Interior Condition");
                        // Rec.TestField("Interior Remarks");
                        // Rec.TestField("Any Scratches");
                        // Rec.TestField("Scratches Description");
                        Rec.TestField("General Mechanical Condition");
                        Rec.TestField("Mechanical Remarks");
                        Rec.TestField("Fuel Level");
                        Rec.TestField("Odometer Reading");
                        Rec.TestField("Next Service");
                        Rec.TestField("Driver's License");
                        Rec.TestField("Defensive Driving Certificate");
                        Rec.TestField("Medical Fitness Certificate");

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
                        ApprovalEntries: Record "Approval Entry";
                        
                    begin

                        Rec.TESTFIELD("Equipment No.");
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        Rec.TestField(Date);
                        Rec.TestField("Former Driver");
                        Rec.TestField("Assigned Driver");
                        // Rec.TestField("Any Dents");
                        // Rec.TestField("Dents Description");
                        // Rec.TestField("Interior Condition");
                        // Rec.TestField("Interior Remarks");
                        // Rec.TestField("Any Scratches");
                        // Rec.TestField("Scratches Description");
                        //Rec.TestField("General Mechanical Condition");
                        Rec.TestField("Mechanical Remarks");
                        Rec.TestField("Fuel Level");
                        Rec.TestField("Odometer Reading");
                        Rec.TestField("Next Service");
                        Rec.TestField("Driver's License");
                        Rec.TestField("Defensive Driving Certificate");
                        Rec.TestField("Medical Fitness Certificate");

                        if Confirm('Are you sure you want to Reject this Requisition ?', true) then begin
                            
                              // Update all open approval entries for this document to Rejected
                            ApprovalEntries.Reset();
                            ApprovalEntries.SetRange("Table ID", Database::"Form Header");
                            ApprovalEntries.SetRange("Document No.", Rec."No.");
                            ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Open, ApprovalEntries.Status::Created);
                            if ApprovalEntries.FindSet() then begin
                                repeat
                                    ApprovalEntries.Status := ApprovalEntries.Status::Rejected;
                                    ApprovalEntries.Modify();
                                until ApprovalEntries.Next() = 0;
                            end;

                            // Update form header status
                            Rec.Status := Rec.Status::Rejected;
                            Rec.Modify();

                            //Checking for comments before rejecting

                            // ApprovalComments.Reset();
                            // ApprovalComments.SetRange(ApprovalComments."No.", Rec."No.");
                            // ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Equipment Hand Over");
                            
                            //if ApprovalComments.FindFirst() then begin
                                
                                ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                                customFunction.RejectApprovalRequestFM(Rec);
                                Rec.SendRejectEmail(Rec);
                            // end else begin
                            //     ApprovalComments2.Reset();
                            //     ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"Equipment Hand Over");
                            //     ApprovalComments2.SetRange(ApprovalComments2."No.", Rec."No.");
                            //     ApprovalComments2.SetRange("Document Line No.", 0);
                            //     approvalComment.SetTableView(ApprovalComments2);
                            //     approvalComment.Run();
                            // end;
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
                        Rec.TestField(Date);
                        Rec.TestField("Former Driver");
                        Rec.TestField("Assigned Driver");
                        Rec.TestField("Any Dents");
                        Rec.TestField("Dents Description");
                        Rec.TestField("Interior Condition");
                        Rec.TestField("Interior Remarks");
                        Rec.TestField("Any Scratches");
                        Rec.TestField("Scratches Description");
                        Rec.TestField("General Mechanical Condition");
                        Rec.TestField("Mechanical Remarks");
                        Rec.TestField("Fuel Level");
                        Rec.TestField("Odometer Reading");
                        Rec.TestField("Next Service");
                        Rec.TestField("Driver's License");
                        Rec.TestField("Defensive Driving Certificate");
                        Rec.TestField("Medical Fitness Certificate");

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
        PreviewMode := true;
        Rec."Document Type" := Rec."Document Type"::"Equipment Hand Over";
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

        // if Rec.Status in [Rec.Status::"Pending Approval", Rec.Status::Released] then
        //     PreviewMode := false;
        
        if Rec.Status in [Rec.Status::"Pending Approval"] then
            PreviewMode := false 
            else PreviewMode := true;
        

        //Ap.RejectApprovalRequestsForRecord();;
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

        Ap : Codeunit "Approvals Mgmt.";
}