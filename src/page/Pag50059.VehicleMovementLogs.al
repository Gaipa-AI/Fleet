page 50059 "Vehicle Movement Logs"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Vehicle Movement Log";
    Editable = false;
    SourceTable = "Form Header";
    SourceTableView = where("Document Type" = filter("Vehicle Movement Log"));

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
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Specifies the value of the Client No. field.', Comment = '%';
                }
                field("Client Name"; Rec."Client Name")
                {
                    ToolTip = 'Specifies the value of the Client Name field.', Comment = '%';
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field("Equipment Model"; Rec."Equipment Model")
                {
                    ToolTip = 'Specifies the value of the Equipment Model field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                }
            }
        }
        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
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
}