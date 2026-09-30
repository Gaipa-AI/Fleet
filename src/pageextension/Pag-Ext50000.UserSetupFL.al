pageextension 50000 "User Setup FL" extends "User setup"
{
    layout
    {
        addafter(PhoneNo)
        {
            field("SBU Head"; Rec."SBU Head")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Budget Controller"; Rec."Budget Controller")
            {
                ApplicationArea = All;
            }
            field("Job Budget Controller"; Rec."Job Budget Controller")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Job Budget Controller field.';
            }
            field("Voucher Admin"; Rec."Voucher Admin")
            {
                ApplicationArea = All;
            }
            field("Archive Document"; Rec."Archive Document")
            {
                ApplicationArea = All;
            }
            field("Requisition Admin"; Rec."Requisition Admin")
            {
                ApplicationArea = All;
            }
            field("Edit Requisition Line"; Rec."Edit Requisition Line")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Edit Requisition Line field.';
            }
            field("Change Amount on Approved Req."; Rec."Change Amount on Approved Req.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Change Amount on Approved Req. field.';
            }
            field("Employee No"; Rec."Employee No")
            {
                ApplicationArea = All;
            }
            field(Admin;Rec.Admin){
                ApplicationArea = All;
            }
            // field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = All;
            // }
            // field("Shortcut Dimension 3 Code";Rec."Shortcut Dimension 3 Code")
            // {
            //     ApplicationArea = All;
            // }
            field("Can Authorize Job"; Rec."Can Authorize Job")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Authorize Job field.', Comment = '%';
            }
            field("Workshop Manager"; Rec."Workshop Manager")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Workshop Manager field.', Comment = '%';
            }
            field("Can Release Requisition"; Rec."Can Release Requisition")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Release Requisition field.', Comment = '%';
            }
            field("Can Authorize Requisition"; Rec."Can Authorize Requisition")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Authorize Requisition field.', Comment = '%';
            }
            field("Can Authorize Hire Request"; Rec."Can Authorize Hire Request")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Can Authorize Hire Request field.', Comment = '%';
            }
        }

    }

    actions
    {
        addfirst(Creation)
        {
            action("User Location")
            {
                ApplicationArea = Basic;
                Caption = 'User Location';
                Image = User;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "User Location Setup";
                RunPageLink = "User ID"=field("User ID");
            }
        }
    }
}