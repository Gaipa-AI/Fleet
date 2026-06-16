page 50064 "Journey Management Plans"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Journey Management Plan";
    Editable = false;
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = const("Journey Management Plan"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Site Name"; Rec."Site Name")
                {
                    ToolTip = 'Specifies the value of the Site Name field.', Comment = '%';
                }
                field("Validity Date"; Rec."Validity Date")
                {
                    ToolTip = 'Specifies the value of the Validity Daily field.', Comment = '%';
                }
                field("JMP Requester No."; Rec."JMP Requester No.")
                {
                    ToolTip = 'Specifies the value of the JMP Requester No. field.', Comment = '%';
                }
                field("JMP Requester Name"; Rec."JMP Requester Name")
                {
                    ToolTip = 'Specifies the value of the JMP Requester Name field.', Comment = '%';
                }
                field("JMP User No."; Rec."JMP User No.")
                {
                    ToolTip = 'Specifies the value of the JMP User No. field.', Comment = '%';
                }
                field("JMP User Name"; Rec."JMP User Name")
                {
                    ToolTip = 'Specifies the value of the JMP User Name field.', Comment = '%';
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    var 
    UserSetupRec: Record "User Setup";
   
    LocationFilter: Text;
    begin
        // Get current user's setup
        if not UserSetupRec.Get(UserId)then Error('User %1 not found in User Setup', UserId);
        Rec.FilterGroup(2);
        // Check user roles and apply appropriate filters
        case true of // Super Admin - sees everything
        UserSetupRec.Admin: begin
            // No filters - they see all records
            Rec.FilterGroup(0);
            exit;
        end;
        // Regular users - see only their own records
        else
            Rec.SetRange("Prepared by", UserId);
        end;
        Rec.FilterGroup(0);
    end;
}