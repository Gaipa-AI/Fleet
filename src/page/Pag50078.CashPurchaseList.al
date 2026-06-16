page 50078 "Cash Purchase List"
{
    ApplicationArea = All;
    Caption = 'Cash Purchase List';
    PageType = List;
    SourceTable = "Cash Purchase";
    UsageCategory = Lists;
    //*
    Editable = false;
    CardPageId = "Cash Purchase";

    //DeleteAllowed = false;
    //*
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No.";Rec."No.")
                {
                }
                field("Document Date";Rec."Document Date")
                {
                }
                field("Shortcut Dimension 1 Code";Rec."Shortcut Dimension 1 Code")
                {
                }
                field(Remarks;Rec.Remarks)
                {
                }
                field(Status;Rec.Status)
                {
                }
                field(Posted;Rec.Posted)
                {
                }
                 field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    trigger OnOpenPage()
var
    UserSetupRec: Record "User Setup";
begin
    // Get current user's setup
    if not UserSetupRec.Get(UserId) then
        Error('User %1 not found in User Setup', UserId);
    // Super Admin check - they see everything
    if UserSetupRec."Admin" then
        exit; // Exit without applying any filter
    // Regular users - filter by User ID only
    Rec.FilterGroup(2);
    Rec.SetRange("User ID", UserId); // Only see their own records
    Rec.FilterGroup(0);
end;

var
    cashline: Record "Cash Purchase Line";
    }
