page 50055 "Incident Form"
{
    Caption = 'Incident Notification Form';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Form Header";
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTableView = where("Document Type" = const("Incident Notification Form"));

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
                    //Editable = IsEditable;
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
                    Editable = true;
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                   // Editable = IsEditable;
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                    
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                    Editable = true;
                    
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                }
                field("Approver"; Rec."Current Approver")
                {
                    ApplicationArea = All;
                    //Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Approver field.', Comment = '%';
                }
              

                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the approval status of the incident form', Comment = '%';

                }
                field("Incident Posted"; Rec."Incident Posted")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Tooltip = 'Specifies the approval status of the incident form', Comment = '%';

                }
                field("Complaint Posted"; Rec."Complaint Posted")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Tooltip = 'Specifies the approval status of the incident form', Comment = '%';

                }
            }
            group(IncidentClassification)
            {
                Caption = 'Incident Classification';
                field("Near Miss"; Rec."Near Miss")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Near Miss field.', Comment = '%';
                }
                field("First Aid Case;"; Rec."First Aid Case;")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Aid Case; field.', Comment = '%';
                }
                field("Medical Treatment Case;"; Rec."Medical Treatment Case;")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Medical Treatment Case; field.', Comment = '%';
                }
                field("Restricted Work Case/Injury;"; Rec."Restricted Work Case/Injury;")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Restricted Work Case/Injury; field.', Comment = '%';
                }
                field("Lost Time Injury"; Rec."Lost Time Injury")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lost Time Injury field.', Comment = '%';
                }
                field(Fatality; Rec.Fatality)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fatality field.', Comment = '%';
                }
                field("Motor Vehicle Crash"; Rec."Motor Vehicle Crash")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Motor Vehicle Crash field.', Comment = '%';
                }
                field("Property Damage/Material Loss"; Rec."Property Damage/Material Loss")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Damage/Material Loss field.', Comment = '%';
                }
                field("Environmental Spill"; Rec."Environmental Spill")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Environmental Spill field.', Comment = '%';
                }
                field(Fire; Rec.Fire)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fire field.', Comment = '%';
                }
                field("Security Incident"; Rec."Security Incident")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Security Incident field.', Comment = '%';
                }
                field("Vector/Vermin Infestation"; Rec."Vector/Vermin Infestation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vector/Vermin Infestation field.', Comment = '%';
                }
                field("Serious Illness"; Rec."Serious Illness")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serious Illness field.', Comment = '%';
                }
                field("Disease Outbreak"; Rec."Disease Outbreak")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Disease Outbreak field.', Comment = '%';
                }
                field(Other; Rec.Other)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other field.', Comment = '%';
                }
            }
            group(IdentificationOfTheIncident)
            {
                Caption = 'Identification of the Incident';

                field("Site Specific Location"; Rec."Site Specific Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Site Specific Location field.', Comment = '%';
                }
                field("Title of Incident"; Rec."Title of Incident")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title of Incident field.', Comment = '%';
                }
                field("Date and Time of Incident"; Rec."Date and Time of Incident")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date and Time of Incident field.', Comment = '%';
                }
                field("Reported Date and Time"; Rec."Reported Date and Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reported Date and Time field.', Comment = '%';
                }
            }
            group(IncidentSummary)
            {
                Caption = 'Incident Summary';
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = true;
                    MultiLine= true;
                    
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Parties Involved"; Rec."Parties Involved")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parties Involved field.', Comment = '%';
                }
                
            }

            group(ClientComplaints){
                Caption = 'Client Complaints';

                field("Complaint No."; Rec."Complaint No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Complaint No. field.', Comment = '%';
                    //Editable = IsEditable;
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;

                }

                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client No. field.', Comment = '%';
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client Name field.', Comment = '%';
                }
                field("Client Complaint Description"; Rec."Client Complaint")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client Complaint Description field.', Comment = '%';
                    MultiLine = true;
                }

            }
            group(Impact)
            {
                Caption = 'Impact';
                field("Was anyone injured?"; Rec."Was anyone injured?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Was anyone injured? field.', Comment = '%';
                }
                field("Was there any property damage?"; Rec."Was there any property damage?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Was there any property damage? field.', Comment = '%';
                }
                field(WasThereAnyEnvironmentalDamage; Rec.WasThereAnyEnvironmentalDamage)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Was there any environmental damage? field.', Comment = '%';
                }
                field("What is the incident severity?"; Rec."What is the incident severity?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the What is the incident severity? field.', Comment = '%';
                }
                field(IncidentInvestigationRequired; Rec.IncidentInvestigationRequired)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incident investigation required? field.', Comment = '%';
                }
                field("AnyOne Injured Description"; Rec."AnyOne Injured Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AnyOne Injured Description field.', Comment = '%';
                }
                field("Property Damaged Description"; Rec."Property Damaged Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Property Damaged Description field.', Comment = '%';
                }
                field("Environment Damage Description"; Rec."Environment Damage Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Environment Damage Description field.', Comment = '%';
                }
                field("Severity Description"; Rec."Severity Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Severity Description field.', Comment = '%';
                }
                field("Investigation Description"; Rec."Investigation Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Investigation Description field.', Comment = '%';
                }
            }
            group(DetailsOfInjuredPerson)
            {
                Caption = 'Details Of Injured Person';
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.', Comment = '%';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the First Name field.', Comment = '%';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Name field.', Comment = '%';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                }
                field("Shift Duration"; Rec."Shift Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shift Duration field.', Comment = '%';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact field.', Comment = '%';
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Residential Address field.', Comment = '%';
                }
                field("SuperVisor No."; Rec."SuperVisor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SuperVisor No. field.', Comment = '%';
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Name field.', Comment = '%';
                }
                field(RelationshipToTheCompany; Rec.RelationshipToTheCompany)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Relationship To The Company field.', Comment = '%';
                }
                field("Description Of Injury/Illness"; Rec."Description Of Injury/Illness")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description Of Injury/Illness field.', Comment = '%';
                }
                field("Body Location"; Rec."Body Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Body Location field.', Comment = '%';
                }
                field("Treatment Given"; Rec."Treatment Given")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Treatment Given field.', Comment = '%';
                }
                field(Referral; Rec.Referral)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Referral field.', Comment = '%';
                }
            }

            part(CorrectiveAction; "Corrective Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
            part(Recommendations; "Recommendation Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Images)
            {
                Visible = false;
                field(Image; Rec.Image)
                {
                    ApplicationArea = All;
                }
            }
            group(Notifier)
            {
                Caption = 'Notifier Details';
                field("Notifier No."; Rec."Notifier No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notifier No. field.', Comment = '%';
                }
                field("Notifier Name"; Rec."Notifier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notifier Name field.', Comment = '%';
                }
                field("Notifier Title"; Rec."Notifier Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notifier Title field.', Comment = '%';
                }
                field("Notifier Work Location"; Rec."Notifier Work Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notifier Work Location field.', Comment = '%';
                }
                field("Notifier Contact"; Rec."Notifier Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notifier Contact field.', Comment = '%';
                }
                field("Notifier Email"; Rec."Notifier Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notifier Email field.', Comment = '%';
                }
                field("Notifier Site Manager"; Rec."Notifier Site Manager")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notifier Site Manager field.', Comment = '%';
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
                    RptPurchaseRequisition: Report "Incident Notification Form";
                begin
                    RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Incident Notification Form");
                    RequisitionHeader.SETRANGE("No.", Rec."No.");
                    RptPurchaseRequisition.SETTABLEVIEW(RequisitionHeader);
                    RptPurchaseRequisition.RUNMODAL;
                end;
            }
            

            group(Request)
            {
                action("Comments")
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Incident Notification Form"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
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
                action(Post)
                {
                    ApplicationArea = All;
                    Caption = 'Post Incident';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    

                    trigger OnAction()
                   
                    begin
                        Rec.TestField(Status, Rec.Status::"Released");
                        Rec.TestField("Driver No.");
                        Rec.TestField("Description");
                        if Confirm('Are you sure you want to post this incident?', true) then
                        Rec.PostIncident();
                        
                    end;

                }
                action(PostComplaint)
                {
                    Caption = 'Post Client Complaint';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                    begin
                        Rec.TestField(Status, Rec.Status::"Released");
                        Rec.TestField("Driver No.");
                        Rec.TestField("Complaint No.");
                        Rec.TestField("Client No.");
                        Rec.TestField("Client Complaint");
                        if Confirm('Are you sure you want to post this complaint?', true) then;
                        Rec.PostClientComplaint();

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
                    //Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
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
                        FormHeader: Record "Form Header";
                    begin
                        CurrPage.Update();
                        Rec.TestField("Driver No.");
                        Rec.TestField("Description");
                        //Rec.TestField("Medical Fitness Certificate");

                        // Check if there is at least one Form Request Lines
                        FormHeader.Reset();
                        FormHeader.SetRange("No.", Rec."No.");
                        if not FormHeader.FindFirst() then
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
                    RunPageLink = "Document Type" = filter("Incident Notification Form"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    //Enabled = ViewCancel;
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

                        Rec.TestField("Driver No.");
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

                        Rec.TestField("Driver No.");
                        //Rec.TestField("Medical Fitness Certificate");
                        if Confirm('Are You Want to Re-open This Document ?', true) then begin
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
                        
                        Rec.TestField("Driver No.");

                       // Rec.TestField("Medical Fitness Certificate");

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

                        //if Confirm('Are you sure you want to post this incident?', true) then
                        //Rec."Incident Posted" := true;
                        Rec.PostIncident();
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

                        
                        Rec.TestField("Driver No.");
                        //Rec.TestField("Medical Fitness Certificate");

                        if Confirm('Are you sure you want to Reject this Requisition ?', true) then begin
                            //Checking for comments before rejecting
                            ApprovalComments.Reset();
                            ApprovalComments.SetRange(ApprovalComments."No.", Rec."No.");
                            ApprovalComments.SetRange(ApprovalComments."Document Type", ApprovalComments."Document Type"::"Incident Notification Form");

                            if ApprovalComments.FindFirst() then begin
                                ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                                Rec.Status := Rec.Status::Rejected;
                                customFunction.RejectApprovalRequestFM(Rec);
                                // customFunction.GetSetFormStatusToRejectedCode(Rec);
                                Rec.SendRejectEmail(Rec);
                            end else begin
                                ApprovalComments2.Reset();
                                ApprovalComments2.SetRange(ApprovalComments2."Document Type", ApprovalComments2."Document Type"::"Incident Notification Form");
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

                        Rec.TestField("Driver No.");
                        //Rec.TestField("Medical Fitness Certificate");

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
        //CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        //WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        if Rec."Status" = Rec.Status::Released then IsEditable := false 
        else IsEditable:= true; 
    end;


    var
       ApprovalsMgmtCut: Codeunit "Fleet Management";
       ApprovalsMgmt: Codeunit "Approvals Mgmt.";
       CancelApprovalVisible: Boolean;
        StatusPending: Boolean;
        customFunction: Codeunit "Fleet Management";
        Text0022: Label 'There must be at least one Driver for this Incident Verification';

        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        IsEditable: Boolean;
}