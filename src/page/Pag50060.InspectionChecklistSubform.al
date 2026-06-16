page 50060 "Inspection Checklist Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Form Line";
    SourceTableView = where("Document Type" = const("Equipment Inspection"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Details field.', Comment = '%';
                }
                // field(Monday; Rec.Monday)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Monday field.', Comment = '%';
                //     Caption = 'Any Issues';
                // }
                // field(Tuesday; Rec.Tuesday)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Tuesday field.', Comment = '%';
                // }
                // field(Wednesday; Rec.Wednesday)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Wednesday field.', Comment = '%';
                // }
                // field(Thursday; Rec.Thursday)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Thursday field.', Comment = '%';
                // }
                // field(Friday; Rec.Friday)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Friday field.', Comment = '%';
                // }
                // field(Saturday; Rec.Saturday)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Saturday field.', Comment = '%';
                // }
                // field(Sunday; Rec.Sunday)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Sunday field.', Comment = '%';
                // }
                // field(Date; Rec.Date)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the date on which Inspection was carried out', Comment = '%';

                // }
                field(Missing; Rec.Missing)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that vehicle part is missing', Comment = '%';

                }
                field(Damaged; Rec.Damaged)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if that part of the vehicle is damaged', Comment = '%';

                }

                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
}