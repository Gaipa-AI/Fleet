// page 50029 "Cash Purchase"
// {
//     Caption = 'Cash Purchase';
//     PageType = Card;
//     SourceTable = "Cash Purchase";
//     //*
//     //DeleteAllowed = false;
//     PromotedActionCategoriesML = ENU='New,Process,Report,Approval Request,Approvals,Conversion,Posting,Archive';

//     //*
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';

//                 field("No.";Rec."No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the No. field.';

//                     trigger OnAssistEdit()begin
//                         if Rec.AssistEdit(xRec)then CurrPage.Update;
//                     end;
//                 }
//                 field("Document Date";Rec."Document Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Document Date field.';
//                 }
//                 field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
//                     Editable = StatusEditable;
//                 }
//                 field("Shortcut Dimension 3 Code";Rec."Shortcut Dimension 3 Code")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = StatusEditable;
//                 }
//                 field("Request Date";Rec."Request Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Request Date field.';
//                     Editable = StatusEditable;
//                 }
//                 field("Location Code";Rec."Location Code")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Location Code field.';
//                     Editable = StatusEditable;
//                 }
//                 field("Inventory Posting Group Filter";Rec."Inventory Posting Group Filter")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Inventory Posting Group Filter field.';
//                     Editable = StatusEditable;
//                     //Visible = false;
//                 }
//                 field("Expected Requisition Date";Rec."Expected Requisition Date")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Expected Requisition Date field.';
//                     Editable = StatusEditable;
//                 }
//                 field(Posted;Rec.Posted)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Status;Rec.Status)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Status field.';
//                 }
//                 field("User ID";Rec."User ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             part(CashPurchaseLine;"Cash purchase Line")
//             {
//                 Caption = 'Lines';
//                 SubPageLink = "Document No."=field("No.");
//                 Editable = PostEditable;
//             }
//             field(Remarks;Rec.Remarks)
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Remarks field.';
//                 MultiLine = true;
//                 Editable = StatusEditable;
//             }
//         }
//     }
//     actions
//     {
//         area(Processing)
//         {
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 Visible = Rec.Status = Rec.Status::Open;

//                 action(SendApprovalRequest)
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Image = SendApprovalRequest;
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Promoted = true;
//                     ApplicationArea = All;
//                     PromotedCategory = Category4;
//                     Visible = Rec.Status = Rec.Status::Open;

//                     trigger OnAction();
//                     var BCSetup: Record "General Ledger Setup";
//                     begin
//                         //#
//                         //Rec.AllKeyfields();
//                         Variant:=Rec;
//                         if CustomApprovals.CheckApprovalsWorkflowEnabled(Variant)then CustomApprovals.OnSendDocForApproval(Variant);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     ApplicationArea = All;
//                     PromotedCategory = Category4;
//                     Visible = Rec.Status = Rec.Status::Open;

//                     trigger OnAction();
//                     begin
//                         //#
//                         Variant:=Rec;
//                         CustomApprovals.OnCancelDocApprovalRequest(Variant);
//                     end;
//                 }
//             }
//             group(Approva)
//             {
//                 action(Approvals)
//                 {
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = true;
//                     ApplicationArea = All;
//                     PromotedCategory = Category5;
//                     Visible = Rec.Status = Rec.Status::"Pending Approval";

//                     trigger OnAction();
//                     var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID)end;
//                 }
//             }
//             group(Process)
//             {
//         action(Archive)
//         {
//             Caption = 'Archive';
//             Image = Archive; // Use an appropriate image
//             Promoted = true;
//             PromotedCategory = Category8;
//             Visible = IsAdmin;

//             trigger OnAction()
//             var
//                 ArchivedCashPurchase: Record "Archived Cash Purchase";
//                 ArchivedCashPurchaseLine: Record "Archived Cash Purchase Line";
//                 CashPurchaseLine: Record "Cash Purchase Line";
//                 cash: Record "Cash Purchase";
//                 IsConfirmed: Boolean;
//             begin
//                 // Check if the status is 'Approved'
//                 if Rec.Status <> Rec.Status::Released then
//                     Error('Status must be equal to ''Approved'' in Cash Purchase: No.=%1. Current value is ''%2''.', Rec."No.", Rec.Status);

//                 IsConfirmed := Confirm('Are you sure you want to archive the selected documents?');
//                 if IsConfirmed then begin
//                     // Archive the header
//                     ArchivedCashPurchase."No." := Rec."No."; // Copy the No.
//                     ArchivedCashPurchase."Document Date" := Rec."Document Date"; // Copy the Document Date
//                     ArchivedCashPurchase."Document Time" := Rec."Document Time"; // Copy the Document Time
//                     ArchivedCashPurchase."User ID" := Rec."User ID"; // Copy the User ID
//                     ArchivedCashPurchase."Remarks" := Rec."Remarks"; // Copy the Remarks
//                     ArchivedCashPurchase."Archived Date" := CurrentDateTime(); // Set the Archived Date
//                     ArchivedCashPurchase.Insert(); // Insert into the archive table

//                     // Archive the lines
//                     CashPurchaseLine.SetRange("Document No.", Rec."No.");
//                     if CashPurchaseLine.FindSet() then begin
//                         repeat
//                             ArchivedCashPurchaseLine."Document No." := CashPurchaseLine."Document No."; // Copy the Document No.
//                             ArchivedCashPurchaseLine."Line No." := CashPurchaseLine."Line No."; // Copy the Line No.
//                             ArchivedCashPurchaseLine."Type" := CashPurchaseLine.Type; // Copy the Type
//                             ArchivedCashPurchaseLine."No." := CashPurchaseLine."No."; // Copy the No.
//                             ArchivedCashPurchaseLine.Description := CashPurchaseLine.Description; // Copy the Description
//                             ArchivedCashPurchaseLine.Location := CashPurchaseLine.Location; // Copy the Location
//                             ArchivedCashPurchaseLine.Quantity := CashPurchaseLine.Quantity; // Copy the Quantity
//                             ArchivedCashPurchaseLine."Unit Cost" := CashPurchaseLine."Unit Cost"; // Copy the Unit Cost
//                             ArchivedCashPurchaseLine.Amount := CashPurchaseLine.Amount; // Copy the Amount
//                             ArchivedCashPurchaseLine."Posted" := CashPurchaseLine.Posted; // Copy the Posted status
//                             ArchivedCashPurchaseLine."Posted By" := CashPurchaseLine."Posted By"; // Copy the Posted By
//                             ArchivedCashPurchaseLine."Date Posted" := CashPurchaseLine."Date Posted"; // Copy the Date Posted
//                             ArchivedCashPurchaseLine."Time Posted" := CashPurchaseLine."Time Posted"; // Copy the Time Posted
//                             ArchivedCashPurchaseLine.Insert(); // Insert into the archive table
//                         until CashPurchaseLine.Next() = 0;
//                     end;

//                      Rec.Delete(true);
//                     CashPurchaseLine.DeleteAll();// Delete the original record from the Cash Purchase table
//                     Message('The selected documents have been archived.');
//                 end;
//             end;
//         }
    
    

//                 action("Create Journal Line")
//                 {
//                     Caption = 'Create Journal Line';
//                     Image = SendApprovalRequest;
//                     //Enabled = NOT OpenApprovalEntriesExist;
//                     Promoted = true;
//                     ApplicationArea = All;
//                     PromotedCategory = Category5;
//                     Visible = false;

//                     trigger OnAction()begin
//                         Message('>>');
//                     end;
//                 }
//                 action("Create Purchase Quote")
//                 {
//                     Caption = 'Create Purchase Quote';
//                     Image = Invoice;
//                     Visible = (Rec.Status = Rec.Status::Released) and (not Rec.Posted);

//                     trigger OnAction()var PurchSetup: Record "Purchases & Payables Setup";
//                     NoSeriesMgmt: Codeunit NoSeriesManagement;
//                     OrderNo: Code[20];
//                     Purchase: Record "Purchase Header";
//                     PurchaseLine: Record "Purchase Line";
//                     CashPurchaseLine: Record "Cash Purchase Line";
//                     Text001: Label 'Purchase Quote %1 has been created';
//                     InventorySetup: Record "Inventory Setup";
//                     LineNo: Integer;
//                     begin
//                         // Validations
//                         Rec.TestField(Posted, false);
//                         if not(CashPurchaseLine.Type in[CashPurchaseLine.Type::Item, CashPurchaseLine.Type::"Fixed Asset"])then Error('Type cannot be G/L Account');
//                         CashPurchaseLine.TestField("Buy-From-Vendor-No.");
//                         CashPurchaseLine.TestField(Amount);
//                         // Get setups
//                         InventorySetup.Get();
//                         InventorySetup.TestField("Store Location");
//                         PurchSetup.Get();
//                         // Get new document number
//                         Clear(OrderNo);
//                         OrderNo:=NoSeriesMgmt.GetnextNo(PurchSetup."Quote Nos.", WorkDate, true);
//                         // Process lines first
//                         LineNo:=10000;
//                         CashPurchaseLine.SetRange("Document No.", Rec."No.");
//                         if CashPurchaseLine.FindSet()then begin
//                             // Initialize header after confirming lines exist
//                             Purchase.Init;
//                             Purchase."Document Type":=Purchase."Document Type"::Quote;
//                             Purchase."No.":=OrderNo;
//                             Purchase.Validate("Buy-from Vendor No.", CashPurchaseLine."Buy-From-Vendor-No.");
//                             Purchase."Order Date":=WorkDate;
//                             Purchase."Posting Date":=WorkDate;
//                             Purchase."Document Date":=WorkDate;
//                             Purchase.Validate("Location Code", CashPurchaseLine.Location);
//                             Purchase."Cash Purchase No.":=CashPurchaseLine."Document No.";
//                             Purchase."Shortcut Dimension 1 Code":=Rec."Shortcut Dimension 1 Code";
//                             Purchase."Shortcut Dimension 2 Code":=Rec."Shortcut Dimension 2 Code";
//                             //Purchase.Validate("Location Code", InventorySetup."Store Location");
//                             Purchase.Insert(true);
//                             // Process lines
//                             repeat PurchaseLine.Init();
//                                 PurchaseLine."Document Type":=Purchase."Document Type";
//                                 PurchaseLine."Document No.":=Purchase."No.";
//                                 PurchaseLine."Line No.":=LineNo;
//                                 PurchaseLine."No.":=CashPurchaseLine."No.";
//                                 PurchaseLine.Description:=CashPurchaseLine.Description;
//                                 PurchaseLine."Unit Cost":=CashPurchaseLine."Unit Cost";
//                                 PurchaseLine."Unit of Measure":=CashPurchaseLine."Unit of Measure Code";
//                                 PurchaseLine."Item Category Code":=CashPurchaseLine."Item Category Code";
//                                 PurchaseLine.Type:=CashPurchaseLine.Type;
//                                 PurchaseLine.Quantity:=CashPurchaseLine.Quantity;
//                                 PurchaseLine."Location Code":=CashPurchaseLine.Location;
//                                 PurchaseLine.Insert(true);
//                                 LineNo+=10000;
//                             until CashPurchaseLine.Next() = 0;
//                             // Update source document
//                             Rec."No.":=Purchase."No.";
//                             Rec.Validate(Posted, true);
//                             Rec.Modify;
//                             if not CheckDocumentforClosure then DocumentClosure();
//                             Message(Text001, Purchase."No.");
//                         end;
//                     end;
//                 }
//             }
//             group(Approval)
//             {
//                 Caption = 'Approval';

//                 action(Approve)
//                 {
//                     Caption = 'Approve';
//                     Image = Approve;
//                     ApplicationArea = All;
//                     Promoted = true;
//                     PromotedCategory = Category7;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID)end;
//                 }
//                 action(Reject)
//                 {
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     ApplicationArea = All;
//                     PromotedCategory = Category7;
//                     PromotedIsBig = true;
//                     PromotedOnly = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID)end;
//                 }
//                 action(Delegate)
//                 {
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     ApplicationArea = All;
//                     PromotedCategory = Category7;
//                     PromotedOnly = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction();
//                     var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID)end;
//                 }
//             }
//             group(Release)
//             {
//                 Visible = false;

//                 action("ReOpen Document")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'ReOpen';
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Category7;
//                     PromotedOnly = true;
//                     Visible = false;

//                     trigger OnAction();
//                     var ApprovalEntries: Record "Approval Entry";
//                     begin
//                         if not Confirm('Are you sure you want to reopen this document?')then Exit;
//                         ApprovalEntries.Reset;
//                         ApprovalEntries.SetRange("Document No.", Rec."No.");
//                         if ApprovalEntries.FindFirst then begin
//                             repeat if(ApprovalEntries.Status in[ApprovalEntries.Status::Open, ApprovalEntries.Status::Created, ApprovalEntries.Status::Rejected, ApprovalEntries.Status::Approved])then begin
//                                     ApprovalEntries.Status:=ApprovalEntries.Status::Canceled;
//                                     ApprovalEntries.Modify;
//                                 end;
//                             until ApprovalEntries.Next = 0;
//                         end;
//                         //#
//                         //Activities.SupportDocumentStatusOpen(Rec."No.", 0);
//                         Rec.Status:=Rec.Status::Open;
//                         Rec.Modify;
//                     end;
//                 }
//             }
//         // 
//         }
//     }
//     // trigger OnOpenPage()
//     // begin
//     //     if UserSetup.Get(UserId()) and UserSetup.Admin then
//     //         IsAdmin := true
//     //     else
//     //         IsAdmin := false;
//     // end;
//     trigger OnAfterGetCurrRecord()begin
//         SetControlAppearance();
//     end;
//     local procedure CheckDocumentforClosure(): Boolean var CashPurchaseLine: Record "Cash Purchase Line";
//     begin
//         CashPurchaseLine.Reset;
//         CashPurchaseLine.SetRange("Document No.", CashPurchaseLine."Document No.");
//         CashPurchaseLine.SetRange(Posted, false);
//         if CashPurchaseLine.FindFirst then exit(true)end;
//     local procedure DocumentClosure()begin
//         if Rec.Get(Rec."No.")then begin
//             Rec.Validate(Posted, true);
//             Rec.Modify;
//         end;
//     end;
//     local procedure SetControlAppearance()begin
//         OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
//         OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
//         CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
//         SetDocumentBasedonStatus();
//     end;
//     local procedure SetDocumentBasedonStatus()begin
//         if Rec.Status = Rec.Status::Open then StatusEditable:=true
//         else
//             StatusEditable:=false;
//         PostEditable:=false;
//         if not Rec.Posted then PostEditable:=true;
//     end;
//     local procedure CheckDocumentStatus(): Boolean begin
//         if Rec.Get(Rec."No.")then begin
//             if Rec.Status = Rec.Status::Open then exit(true)
//             else if(Rec.Status in[Rec.Status::"Pending Approval"])then exit(false)
//                 else if Rec.Status = Rec.Status::Released then exit(false);
//         end;
//     end;
//     local procedure SetDocumentActionStatus(): Boolean begin
//         if Rec.Get(Rec."No.")then begin
//             if(Rec.Status in[Rec.Status::Released])then exit(true)
//             else
//                 exit(false);
//         end;
//     end;
//     local procedure UpdateLinesWithLocationCode()var CashLine: Record "Cash Purchase Line"; // Replace with the appropriate line table
//     begin
//         // Filter lines by the document number or any other necessary criteria
//         CashLine.SetRange("Document No.", Rec."No."); // Adjust the field and filter as needed
//         // Loop through each line and update the Location Code
//         if CashLine.FindSet()then begin
//             repeat CashLine.Validate("Location", Rec."Location Code");
//                 CashLine.Modify(true);
//             until CashLine.Next() = 0;
//         end;
//     end;
//     var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
//     OpenApprovalEntriesExistForCurrUser: Boolean;
//     OpenApprovalEntriesExist: Boolean;
//     CanCancelApprovalForRecord: Boolean;
//     StatusEditable: Boolean;
//     Variant: Variant;
//     CustomApprovals: Codeunit "Workflow_Approval";
//     PostEditable: Boolean;
//     cashl: Record "Cash Purchase Line";
//     UserSetup: Record "User Setup";
//      IsAdmin: Boolean;
// }
page 50076"Cash Purchase"
{
    Caption = 'Cash Purchase';
    PageType = Card;
    SourceTable = "Cash Purchase";
    //*
    //DeleteAllowed = false;
    PromotedActionCategoriesML = ENU='New,Process,Report,Send Approval Request,Approvals,Conversion,Posting,Archive';

    //*
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No.";Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()begin
                        if Rec.AssistEdit(xRec)then CurrPage.Update;
                    end;
                }
                field("Document Date";Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                    Editable = StatusEditable;
                }
                field("Shortcut Dimension 3 Code";Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Editable = StatusEditable;
                }
                field("Request Date";Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Date field.';
                    Editable = StatusEditable;
                }
                field("Location Code";Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                    Editable = StatusEditable;
                }
                field("Inventory Posting Group Filter";Rec."Inventory Posting Group Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory Posting Group Filter field.';
                    Editable = StatusEditable;
                    //Visible = false;
                }
                field("Expected Requisition Date";Rec."Expected Requisition Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Requisition Date field.';
                    Editable = StatusEditable;
                }
                field(Posted;Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable= false;
                }
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
            part(CashPurchaseLine;"Cash purchase Line")
            {
                Caption = 'Lines';
                SubPageLink = "Document No."=field("No.");
                Editable = PostEditable;
            }
            field(Remarks;Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
                MultiLine = true;
                Editable = StatusEditable;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                //Visible = Rec.Status = Rec.Status::Open;

                action(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Enabled = NOT OpenApprovalEntriesExist;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category4;
                    Visible = Rec.Status = Rec.Status::Open;

                    trigger OnAction();
                    var BCSetup: Record "General Ledger Setup";
                    begin
                        //#
                        //Rec.AllKeyfields();
                        Variant:=Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(Variant)then CustomApprovals.OnSendDocForApproval(Variant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    //Enabled = OpenApprovalEntriesExist;
                    Enabled = Rec.Status = Rec.Status::"Pending Approval";
                    Image = Cancel;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category4;
                    //Visible = Rec.Status = Rec.Status::Open;

                    trigger OnAction();
                    begin
                        //#
                        Variant:=Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(Variant);
                    end;
                }
            }
            group(Approva)
            {
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category5;
                    Visible = true;
                    //Visible = Rec.Status = Rec.Status::"Pending Approval";

                    trigger OnAction();
                    var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RECORDID)end;
                }
            }
            group(Process)
            {
        action(Archive)
        {
            Caption = 'Archive';
            Image = Archive; // Use an appropriate image
            Promoted = true;
            PromotedCategory = Category8;
            Visible = IsAdmin;

            trigger OnAction()
            var
                ArchivedCashPurchase: Record "Archived Cash Purchase";
                ArchivedCashPurchaseLine: Record "Archived Cash Purchase Line";
                CashPurchaseLine: Record "Cash Purchase Line";
                cash: Record "Cash Purchase";
                IsConfirmed: Boolean;
            begin
                // Check if the status is 'Released'
                if Rec.Status <> Rec.Status::Released then
                    Error('Status must be equal to ''Approved'' in Cash Purchase: No.=%1. Current value is ''%2''.', Rec."No.", Rec.Status);

                IsConfirmed := Confirm('Are you sure you want to archive the selected documents?');
                if IsConfirmed then begin
                    // Archive the header
                    ArchivedCashPurchase."No." := Rec."No."; // Copy the No.
                    ArchivedCashPurchase."Document Date" := Rec."Document Date"; // Copy the Document Date
                    ArchivedCashPurchase."Document Time" := Rec."Document Time"; // Copy the Document Time
                    ArchivedCashPurchase."User ID" := Rec."User ID"; // Copy the User ID
                    ArchivedCashPurchase."Remarks" := Rec."Remarks"; // Copy the Remarks
                    ArchivedCashPurchase."Archived Date" := CurrentDateTime(); // Set the Archived Date
                    ArchivedCashPurchase.Insert(); // Insert into the archive table

                    // Archive the lines
                    CashPurchaseLine.SetRange("Document No.", Rec."No.");
                    if CashPurchaseLine.FindSet() then begin
                        repeat
                            ArchivedCashPurchaseLine."Document No." := CashPurchaseLine."Document No."; // Copy the Document No.
                            ArchivedCashPurchaseLine."Line No." := CashPurchaseLine."Line No."; // Copy the Line No.
                            ArchivedCashPurchaseLine."Type" := CashPurchaseLine.Type; // Copy the Type
                            ArchivedCashPurchaseLine."No." := CashPurchaseLine."No."; // Copy the No.
                            ArchivedCashPurchaseLine.Description := CashPurchaseLine.Description; // Copy the Description
                            ArchivedCashPurchaseLine.Location := CashPurchaseLine.Location; // Copy the Location
                            ArchivedCashPurchaseLine.Quantity := CashPurchaseLine.Quantity; // Copy the Quantity
                            ArchivedCashPurchaseLine."Unit Cost" := CashPurchaseLine."Unit Cost"; // Copy the Unit Cost
                            ArchivedCashPurchaseLine.Amount := CashPurchaseLine.Amount; // Copy the Amount
                            ArchivedCashPurchaseLine."Posted" := CashPurchaseLine.Posted; // Copy the Posted status
                            ArchivedCashPurchaseLine."Posted By" := CashPurchaseLine."Posted By"; // Copy the Posted By
                            ArchivedCashPurchaseLine."Date Posted" := CashPurchaseLine."Date Posted"; // Copy the Date Posted
                            ArchivedCashPurchaseLine."Time Posted" := CashPurchaseLine."Time Posted"; // Copy the Time Posted
                            ArchivedCashPurchaseLine.Insert(); // Insert into the archive table
                        until CashPurchaseLine.Next() = 0;
                    end;

                     Rec.Delete(true);
                    CashPurchaseLine.DeleteAll();// Delete the original record from the Cash Purchase table
                    Message('The selected documents have been archived.');
                end;
            end;
        }
    
    

                action("Create Journal Line")
                {
                    Caption = 'Create Journal Line';
                    Image = SendApprovalRequest;
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category5;
                    Visible = false;

                    trigger OnAction()begin
                        Message('>>');
                    end;
                }
                action("Create Purchase Quote")
                {
                    Caption = 'Create Purchase Quote';
                    Image = Invoice;
                    Visible = (Rec.Status = Rec.Status::Released) and (not Rec.Posted);

                    trigger OnAction()var PurchSetup: Record "Purchases & Payables Setup";
                    NoSeriesMgmt: Codeunit NoSeriesManagement;
                    OrderNo: Code[20];
                    Purchase: Record "Purchase Header";
                    PurchaseLine: Record "Purchase Line";
                    CashPurchaseLine: Record "Cash Purchase Line";
                    Text001: Label 'Purchase Quote %1 has been created';
                    InventorySetup: Record "Inventory Setup";
                    LineNo: Integer;
                    begin
                        // Validations
                        Rec.TestField(Posted, false);
                        if not(CashPurchaseLine.Type in[CashPurchaseLine.Type::Item, CashPurchaseLine.Type::"Fixed Asset"])then Error('Type cannot be G/L Account');
                        CashPurchaseLine.TestField("Buy-From-Vendor-No.");
                        CashPurchaseLine.TestField(Amount);
                        // Get setups
                        InventorySetup.Get();
                        InventorySetup.TestField("Store Location");
                        PurchSetup.Get();
                        // Get new document number
                        Clear(OrderNo);
                        OrderNo:=NoSeriesMgmt.GetnextNo(PurchSetup."Quote Nos.", WorkDate, true);
                        // Process lines first
                        LineNo:=10000;
                        CashPurchaseLine.SetRange("Document No.", Rec."No.");
                        if CashPurchaseLine.FindSet()then begin
                            // Initialize header after confirming lines exist
                            Purchase.Init;
                            Purchase."Document Type":=Purchase."Document Type"::Quote;
                            Purchase."No.":=OrderNo;
                            Purchase.Validate("Buy-from Vendor No.", CashPurchaseLine."Buy-From-Vendor-No.");
                            Purchase."Order Date":=WorkDate;
                            Purchase."Posting Date":=WorkDate;
                            Purchase."Document Date":=WorkDate;
                            Purchase.Validate("Location Code", CashPurchaseLine.Location);
                            Purchase."Cash Purchase No.":=CashPurchaseLine."Document No.";
                            Purchase."Shortcut Dimension 1 Code":=Rec."Shortcut Dimension 1 Code";
                            Purchase."Shortcut Dimension 2 Code":=Rec."Shortcut Dimension 2 Code";
                            Purchase.Validate("Location Code", InventorySetup."Store Location");
                            Purchase.Insert(true);
                            // Process lines
                            repeat PurchaseLine.Init();
                                PurchaseLine."Document Type":=Purchase."Document Type";
                                PurchaseLine."Document No.":=Purchase."No.";
                                PurchaseLine."Line No.":=LineNo;
                                PurchaseLine."No.":=CashPurchaseLine."No.";
                                PurchaseLine.Description:=CashPurchaseLine.Description;
                                PurchaseLine."Unit Cost":=CashPurchaseLine."Unit Cost";
                                PurchaseLine."Unit of Measure":=CashPurchaseLine."Unit of Measure Code";
                                PurchaseLine."Item Category Code":=CashPurchaseLine."Item Category Code";
                                PurchaseLine.Type:=CashPurchaseLine.Type;
                                PurchaseLine.Quantity:=CashPurchaseLine.Quantity;
                                PurchaseLine."Location Code":=CashPurchaseLine.Location;
                                PurchaseLine.Insert(true);
                                LineNo+=10000;
                            until CashPurchaseLine.Next() = 0;
                            // Update source document
                            Rec."No.":=Purchase."No.";
                            Rec.Validate(Posted, true);
                            Rec.Modify;
                            if not CheckDocumentforClosure then DocumentClosure();
                            Message(Text001, Purchase."No.");
                        end;
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';

                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID)end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var 
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    AppMgt: Codeunit "Workflow EventHandling Ext";
                    begin
                     //Rec.Status := Rec.Status::Rejected;
                     ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                     customApp.RejectApprovalRequestCP(Rec);
                     
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category7;
                    PromotedOnly = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID)end;
                }
            }
            group(Release)
            {
                Visible = false;

                action("ReOpen Document")
                {
                    ApplicationArea = All;
                    Caption = 'ReOpen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction();
                    var ApprovalEntries: Record "Approval Entry";
                    begin
                        if not Confirm('Are you sure you want to reopen this document?')then Exit;
                        ApprovalEntries.Reset;
                        ApprovalEntries.SetRange("Document No.", Rec."No.");
                        if ApprovalEntries.FindFirst then begin
                            repeat if(ApprovalEntries.Status in[ApprovalEntries.Status::Open, ApprovalEntries.Status::Created, ApprovalEntries.Status::Rejected, ApprovalEntries.Status::Approved])then begin
                                    ApprovalEntries.Status:=ApprovalEntries.Status::Canceled;
                                    ApprovalEntries.Modify;
                                end;
                            until ApprovalEntries.Next = 0;
                        end;
                        //#
                        //Activities.SupportDocumentStatusOpen(Rec."No.", 0);
                        Rec.Status:=Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
            }
        // 
        }
    }
    // trigger OnOpenPage()
    // begin
    //     if UserSetup.Get(UserId()) and UserSetup.Admin then
    //         IsAdmin := true
    //     else
    //         IsAdmin := false;
    // end;
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;
    local procedure CheckDocumentforClosure(): Boolean var CashPurchaseLine: Record "Cash Purchase Line";
    begin
        CashPurchaseLine.Reset;
        CashPurchaseLine.SetRange("Document No.", CashPurchaseLine."Document No.");
        CashPurchaseLine.SetRange(Posted, false);
        if CashPurchaseLine.FindFirst then exit(true)end;
    local procedure DocumentClosure()begin
        if Rec.Get(Rec."No.")then begin
            Rec.Validate(Posted, true);
            Rec.Modify;
        end;
    end;
    local procedure SetControlAppearance()
    begin
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        SetDocumentBasedonStatus();
    end;
    local procedure SetDocumentBasedonStatus()begin
        if Rec.Status = Rec.Status::Open then StatusEditable:=true
        else
            StatusEditable:=false;
        PostEditable:=false;
        if not Rec.Posted then PostEditable:=true;
    end;
    local procedure CheckDocumentStatus(): Boolean begin
        if Rec.Get(Rec."No.")then begin
            if Rec.Status = Rec.Status::Open then exit(true)
            else if(Rec.Status in[Rec.Status::"Pending Approval"])then exit(false)
                else if Rec.Status = Rec.Status::Released then exit(false);
        end;
    end;
    local procedure SetDocumentActionStatus(): Boolean begin
        if Rec.Get(Rec."No.")then begin
            if(Rec.Status in[Rec.Status::Released])then exit(true)
            else
                exit(false);
        end;
    end;
    local procedure UpdateLinesWithLocationCode()var CashLine: Record "Cash Purchase Line"; // Replace with the appropriate line table
    begin
        // Filter lines by the document number or any other necessary criteria
        CashLine.SetRange("Document No.", Rec."No."); // Adjust the field and filter as needed
        // Loop through each line and update the Location Code
        if CashLine.FindSet()then begin
            repeat CashLine.Validate("Location", Rec."Location Code");
                CashLine.Modify(true);
            until CashLine.Next() = 0;
        end;
    end;
    var ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    StatusEditable: Boolean;
    Variant: Variant;
    CustomApprovals: Codeunit "Workflow_Approval";
    PostEditable: Boolean;
    cashl: Record "Cash Purchase Line";
    UserSetup: Record "User Setup";
     IsAdmin: Boolean;

     customApp : codeunit "Fleet Management";
}

