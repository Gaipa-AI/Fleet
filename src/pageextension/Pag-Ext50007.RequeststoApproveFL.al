/// <summary>
/// PageExtension Requests to Approve Ext (ID 50042) extends Record Requests to Approve.
/// </summary>
pageextension 50007 "Requests to Approve FL" extends "Requests to Approve"
{

    layout
    {
        modify(Comment) { Visible = false; }
        modify("Amount (LCY)") { Visible = false; }
        addbefore(ToApprove)
        {
            field("Document No."; Rec."Document No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Due Date")
        {

            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Requisition Pillar Code';
                ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
            }
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
                Caption = 'Requisition Project Code';
                ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
            }
        }
        addafter("Currency Code")
        {
            field("Payee No."; Rec."Payee No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payee No. field.';
            }
            field("Payee Name"; Rec."Payee Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Payee Name field.';
            }
        }
    }

    actions
    {

        modify(Approve)
        {
            Visible = true;
            trigger OnBeforeAction()
            var
                IsPurchaseRequisition: Boolean;
                IsCashVoucher: Boolean;
                IsLeaveApplication: Boolean;
                PurchaseRequisition: Record "ADT Requisition Header";
            begin
                IsCashVoucher := false;
                IsPurchaseRequisition := false;
                IsLeaveApplication := false;

                PurchaseRequisition.Reset();
                PurchaseRequisition.SetRange("No.", Rec."Document No.");
                if PurchaseRequisition.FindFirst() then
                    IsPurchaseRequisition := true;

                PurchaseRequisition.Reset();
                PurchaseRequisition.SetRange("No.", Rec."Document No.");
                if PurchaseRequisition.FindFirst() then begin
                    if PurchaseRequisition."Document Type" = PurchaseRequisition."Document Type"::"Purchase Requisition" then begin
                        PurchaseRequisition.PurchaseRequisitionApprove(PurchaseRequisition);
                        error('');
                    end else begin
                        PurchaseRequisition.StoreRequisitionApprove(PurchaseRequisition);
                        error('');
                    end;
                end;
            end;
        }
        modify(Reject)
        {
            Visible = true;
            trigger OnBeforeAction()
            var
                IsPurchaseRequisition: Boolean;
                IsCashVoucher: Boolean;
                PurchaseRequisition: Record "ADT Requisition Header";
            begin
                IsCashVoucher := false;
                IsPurchaseRequisition := false;

                PurchaseRequisition.Reset();
                PurchaseRequisition.SetRange("No.", Rec."Document No.");
                if PurchaseRequisition.FindFirst() then begin
                    if PurchaseRequisition."Document Type" = PurchaseRequisition."Document Type"::"Purchase Requisition" then begin
                        PurchaseRequisition.PurchaseRequisitionReject(PurchaseRequisition);
                        error('');
                    end else begin
                        PurchaseRequisition.StoreRequisitionReject(PurchaseRequisition);
                        error('');
                    end;
                end;
            end;
        }
        modify(Delegate)
        {
            Visible = true;
            trigger OnBeforeAction()
            var
                IsPurchaseRequisition: Boolean;
                IsCashVoucher: Boolean;
                PurchaseRequisition: Record "ADT Requisition Header";
            begin
                IsCashVoucher := false;
                IsPurchaseRequisition := false;

                PurchaseRequisition.Reset();
                PurchaseRequisition.SetRange("No.", Rec."Document No.");
                if PurchaseRequisition.FindFirst() then
                    IsPurchaseRequisition := true;

                PurchaseRequisition.Reset();
                PurchaseRequisition.SetRange("No.", Rec."Document No.");
                if PurchaseRequisition.FindFirst() then begin
                    if PurchaseRequisition."Document Type" = PurchaseRequisition."Document Type"::"Purchase Requisition" then begin
                        PurchaseRequisition.PurchaseRequisitionDelegate(PurchaseRequisition);
                        error('');
                    end else begin
                        PurchaseRequisition.StoreRequisitionDelegate(PurchaseRequisition);
                        error('');
                    end;
                end;
            end;
        }
        modify(Comments)
        {
            Visible = true;
        }
    }

    var
        VisibleApprove: Boolean;
        VisibleReject: Boolean;
        VisibleDelegate: Boolean;

    trigger OnAfterGetRecord()
    begin
        if (Rec."Table ID" = Database::"ADT Requisition Header") then begin
            VisibleApprove := false;
            VisibleReject := false;
            VisibleDelegate := false;
        end;
    end;
}