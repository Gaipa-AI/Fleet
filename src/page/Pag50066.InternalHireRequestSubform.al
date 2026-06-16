page 50066 "Internal Hire Request Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Form Line";
    SourceTableView = WHERE("Document Type" = FILTER("Internal Hire"));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Equipment No."; Rec."Equipment No.")
                {
                    Caption = 'Vehicle No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    Caption = 'Vehicle Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    Caption = 'Vehicle RegNo';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field("Equipment Make"; Rec."Equipment Make")
                {
                    Caption = 'Vehicle Make';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Make field.', Comment = '%';
                }
                field("Equipment Model"; Rec."Equipment Model")
                {
                    Caption = 'Vehicle Model';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Model field.', Comment = '%';
                }
                field("Equipment Serial No."; Rec."Equipment Serial No.")
                {
                    Caption = 'Vehicle Serial No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Serial No. field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    Caption = 'Vehicle Type';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
            }
        }

    }
}